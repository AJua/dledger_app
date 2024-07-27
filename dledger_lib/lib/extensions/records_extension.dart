import 'package:collection/collection.dart';
import 'package:dledger_lib/models/posting.dart';

extension PostingsExtension on Iterable<Posting> {
  Map<String, List<Posting>> groupByAccount({required int depth}) {
    var map = groupListsBy((r) => r.account.hierarchy[1]);
    for (int i = 2; i <= depth; i++) {
      map.addAll(where((r) => r.account.hierarchy.length > i)
          .groupListsBy((r) => r.account.hierarchy[i]));
    }
    return map;
  }
}
