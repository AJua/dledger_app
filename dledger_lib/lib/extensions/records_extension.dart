import 'package:collection/collection.dart';
import 'package:dledger_lib/models/account_record.dart';

extension RecordsExtension on Iterable<AccountRecord> {
  Map<String, List<AccountRecord>> groupByAccount({required int depth}) {
    var map = groupListsBy((r) => r.account.hierarchy[1]);
    for (int i = 2; i <= depth; i++) {
      map.addAll(where((r) => r.account.hierarchy.length > i)
          .groupListsBy((r) => r.account.hierarchy[i]));
    }
    return map;
  }
}
