import '../models/posting.dart';

class IncomeStatement {
  DateTime statementDate;
  Iterable<Posting> incomes;
  Iterable<Posting> expenses;

  IncomeStatement(
      {required this.statementDate,
      required this.incomes,
      required this.expenses});
}
