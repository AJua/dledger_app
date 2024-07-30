import '../models/account.dart';
import '../models/commodity.dart';

extension SummaryExtension on Map<Account, Map<String, Commodity>> {
  Map<String, Map<String, Commodity>> expandAccount(int depth) {
    Map<String, Map<String, Commodity>> output = {};
    forEach((key, value) {
      var prefix = '';
      for (var i = 0; i < depth && i < key.hierarchy.length; i++) {
        var accountHierarchy = '$prefix${key.hierarchy[i]}';
        if (output.containsKey(accountHierarchy)) {
          output[accountHierarchy] = _add(output[accountHierarchy]!, value);
        } else {
          output[accountHierarchy] = value;
        }
        prefix = '  $prefix';
      }
    });

    List<String> intervals = output.values.fold([], (s, e) {
      return [...s, ...e.keys];
    });
    for (var interval in intervals) {
      for (var e in output.values) {
        if (!e.containsKey(interval)) {
          e[interval] = Commodity.zero();
        }
      }
    }
    return output;
  }

  Map<String, Commodity> _add(
      Map<String, Commodity> g1, Map<String, Commodity> g2) {
    Map<String, Commodity> result = {};
    var dates = <String>{...g1.keys, ...g2.keys};
    for (var date in dates) {
      if (g1.containsKey(date)) {
        result[date] = g2.containsKey(date) ? g1[date]! + g2[date]! : g1[date]!;
      } else {
        result[date] = g2[date]!;
      }
    }

    return result;
  }
}
