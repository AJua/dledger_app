import '../models/journal.dart';
import '../models/posting.dart';
import '../reports/income_statement_legacy.dart';

class IncomeStatementReporter {
  IncomeStatementLegacy getIncomeStatement(Journal journal) {
    Iterable<Posting> totalRecords =
        journal.transactions.fold([], (records, transaction) => [...records, ...transaction.postings]);
    return IncomeStatementLegacy(
      statementDate: DateTime(1),
      incomes: totalRecords.where((r) => r.primaryAccount == 'income'),
      expenses: totalRecords.where((r) => r.primaryAccount == 'expenses'),
    );
  }
}
