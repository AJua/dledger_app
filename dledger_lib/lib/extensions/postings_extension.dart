import 'package:collection/collection.dart';
import 'package:dledger_lib/models/commodity.dart';
import 'package:dledger_lib/models/posting.dart';
import 'package:intl/intl.dart';

import '../models/account.dart';

extension PostingsExtension on Iterable<Posting> {
  Map<String, List<Posting>> groupByAccount({required int depth}) {
    var map = groupListsBy((r) => r.account.hierarchy[1]);
    for (int i = 2; i <= depth; i++) {
      map.addAll(where((r) => r.account.hierarchy.length > i)
          .groupListsBy((r) => r.account.hierarchy[i]));
    }
    return map;
  }

  Map<Account, Map<String, Commodity>> summarize() {
    var m2 = groupFoldBy<Account, Map<String, Commodity>>((p) => p.account,
        (previous, posting) {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      var key = formatter.format(posting.date);
      if (previous == null) {
        return {key: posting.commodity};
      }
      if (previous.containsKey(key)) {
        previous[key] = previous[key]! + posting.commodity;
      } else {
        previous[key] = posting.commodity;
      }
      return previous;
    });
    return m2;
  }
}
