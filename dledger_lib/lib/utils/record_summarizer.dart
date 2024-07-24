import 'package:dledger_lib/models/account_record.dart';

extension RecordsExtension on Iterable<AccountRecord> {
  Iterable<AccountRecord> groupByAccount({required int depth}) {
    if (depth == 1) {
      var g = map(
          (r) => {'account': r.account.hierarchy[2], 'amount': r.commodity});
    }
    return [];
  }
}
