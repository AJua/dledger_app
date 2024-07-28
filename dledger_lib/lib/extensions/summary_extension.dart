import 'package:dledger_lib/models/commodity.dart';

import '../models/account.dart';

extension SummaryExtension on Map<Account, Map<String, Commodity>> {
  Map<String, Map<String, Commodity>> expandAccount(int depth) {
    Map<String, Map<String, Commodity>> output = {};
    forEach((key, value) {
      var prefix = '';
      for (var i = 0; i < depth && i < key.hierarchy.length; i++) {
        var account = key.hierarchy[i];
        output['$prefix$account'] = value;
        prefix = '  $prefix';
      }
    });
    return output;
  }
}
