import '../models/posting.dart';

class IncomeStatementLegacy {
  DateTime statementDate;
  Iterable<Posting> incomes;
  Iterable<Posting> expenses;

  IncomeStatementLegacy({required this.statementDate, required this.incomes, required this.expenses});
}
