import 'package:dledger_lib/models/commodity.dart';

class IncomeStatement {
  final Map<String, Map<String, Commodity>> incomes;
  final Map<String, Map<String, Commodity>> expenses;

  /// Creates the employee class with required details.
  IncomeStatement(this.incomes, this.expenses);
}
