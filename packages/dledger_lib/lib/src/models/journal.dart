import 'package:collection/collection.dart';
import 'package:dledger_lib/src/aggregates/financial_stats.dart';
import 'package:dledger_lib/src/reports/income_statement.dart';
import 'package:flutter/foundation.dart';

import 'account.dart';
import 'posting.dart';
import 'statement_period.dart';
import 'transaction.dart';

class Journal with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;
  List<Transaction> _transactions;

  List<Transaction> get transactions => _transactions.toList(growable: false);

  Iterable<Posting> get postings => _transactions.fold<Iterable<Posting>>(
      [],
      (
        postings,
        transaction,
      ) =>
          [...transaction.postings, ...postings]);

  Journal._(this._transactions);

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('transactions', _transactions.join(', ')));
  }

  factory Journal.init() {
    return Journal._([]);
  }

  addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }

  reload(List<Transaction> transactions) {
    _transactions = transactions;
    _isLoaded = true;
    notifyListeners();
  }

  IncomeStatement getIncomeStatement(
      {DateTime? begin,
      DateTime? end,
      PeriodType type = PeriodType.monthly,
      int depth = -1 >>> 1}) {
    var result = postings.groupFoldBy<AccountCategory, FinancialStats>(
        (posting) => posting.account.category, (previous, posting) {
      if (previous == null) {
        return FinancialStats.empty(PeriodType.monthly,
            isTree: true, depth: depth)
          ..add(posting);
      }
      return previous..add(posting);
    });
    var periods = result.entries.fold<Set<StatementPeriod>>(
        {}, (ps, s) => ps..addAll(s.value.distinctPeriods));
    for (var entry in result.entries) {
      entry.value.fillNullValueWithEmpty(periods);
    }
    return IncomeStatement(result);
  }
}
