import 'package:equatable/equatable.dart';

import '../aggregates/financial_stats.dart';
import '../models/account.dart';

class IncomeStatement extends Equatable {
  final Map<AccountCategory, FinancialStats> _statements;

  const IncomeStatement(this._statements);

  FinancialStats? get incomes => _statements[AccountCategory.income];

  FinancialStats? get expenses => _statements[AccountCategory.expenses];

  @override
  List<Object?> get props => [incomes, expenses];
}
