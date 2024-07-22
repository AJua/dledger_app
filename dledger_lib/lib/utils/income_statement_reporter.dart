import 'package:dledger_lib/models/account_record.dart';
import 'package:dledger_lib/models/journal.dart';

class IncomeStatementReporter {
  IncomeStatement getIncomeStatement(Journal journal) {
    var transactions = journal.transactions;
    return IncomeStatement(
      statementDate: DateTime(1),
      incomes: transactions.fold(
        [],
        (incomes, transaction) => [
          ...incomes,
          ...transaction.records
              .where((r) => r.account.hierarchy[0] == 'income')
        ],
      ),
      expenses: transactions.fold(
        [],
        (incomes, transaction) => [
          ...incomes,
          ...transaction.records
              .where((r) => r.account.hierarchy[0] == 'expenses')
        ],
      ),
    );
  }
}

class IncomeStatement {
  DateTime statementDate;
  Iterable<AccountRecord> incomes;
  Iterable<AccountRecord> expenses;

  IncomeStatement(
      {required this.statementDate,
      required this.incomes,
      required this.expenses});
}
