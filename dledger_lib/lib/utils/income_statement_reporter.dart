import 'package:dledger_lib/models/journal.dart';
import 'package:dledger_lib/models/posting.dart';

class IncomeStatementReporter {
  IncomeStatement getIncomeStatement(Journal journal) {
    Iterable<Posting> totalRecords = journal.transactions.fold(
        [], (records, transaction) => [...records, ...transaction.records]);
    return IncomeStatement(
      statementDate: DateTime(1),
      incomes: totalRecords.where((r) => r.primaryAccount == 'income'),
      expenses: totalRecords.where((r) => r.primaryAccount == 'expenses'),
    );
  }
}

class IncomeStatement {
  DateTime statementDate;
  Iterable<Posting> incomes;
  Iterable<Posting> expenses;

  IncomeStatement(
      {required this.statementDate,
      required this.incomes,
      required this.expenses});
}
