import 'package:dledger_lib/dledger_lib.dart';

class IncomeStatementView {
  final Map<String, Map<String, Commodity>> incomes;
  final Map<String, Map<String, Commodity>> expenses;

  /// Creates the employee class with required details.
  IncomeStatementView(this.incomes, this.expenses);
}
