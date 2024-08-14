import 'package:collection/collection.dart';
import 'package:dledger_lib/dledger_lib.dart';
import 'package:intl/intl.dart';

extension PostingsExtension on Iterable<Posting> {
  FinancialStats toStatements(PeriodType type) {
    return fold(
      FinancialStats.empty(type),
      (statements, posting) => statements..add(posting),
    );
  }

  Map<String, List<Posting>> groupByAccount({required int depth}) {
    var map = groupListsBy((r) => r.account.hierarchy[1]);
    for (int i = 2; i <= depth; i++) {
      map.addAll(where((r) => r.account.hierarchy.length > i).groupListsBy((r) => r.account.hierarchy[i]));
    }
    return map;
  }

  Map<Account, Map<String, Commodity>> summarize({PeriodType period = PeriodType.daily}) {
    var m2 = groupFoldBy<Account, Map<String, Commodity>>((p) => p.account, (previous, posting) {
      final DateFormat formatter = _getDateFormat(period);
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

  IncomeStatementLegacy getIncomeStatement({int depth = 2, PeriodType type = PeriodType.monthly}) {
    throw Exception('Not implement yet');
  }

  DateFormat _getDateFormat(PeriodType period) {
    switch (period) {
      case PeriodType.daily:
        return DateFormat('yyyy-MM-dd');
      case PeriodType.weekly:
        throw Exception('weekly is not implemented yet');
      case PeriodType.monthly:
        return DateFormat('yyyy-MM');
      case PeriodType.yearly:
        return DateFormat('yyyy');
    }
  }
}
