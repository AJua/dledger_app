import '../aggregates/financial_stats.dart';
import '../models/account.dart';

class IncomeStatement {
  final Map<AccountCategory, FinancialStats> _statements;

  IncomeStatement(this._statements);

  FinancialStats? get incomes => _statements[AccountCategory.income];

  FinancialStats? get expenses => _statements[AccountCategory.expenses];
}
