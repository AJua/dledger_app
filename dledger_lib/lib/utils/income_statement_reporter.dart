import 'package:dledger_lib/models/account_record.dart';
import 'package:dledger_lib/models/journal.dart';

class IncomeStatementReporter {
  IncomeStatement getIncomeStatement(Journal journal) {
    Iterable<AccountRecord> totalRecords = journal.transactions.fold(
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
  Iterable<AccountRecord> incomes;
  Iterable<AccountRecord> expenses;

  IncomeStatement(
      {required this.statementDate,
      required this.incomes,
      required this.expenses});
}
