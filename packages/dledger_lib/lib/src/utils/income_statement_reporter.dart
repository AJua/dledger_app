import '../models/journal.dart';
import '../models/posting.dart';
import '../reports/income_statement.dart';

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
