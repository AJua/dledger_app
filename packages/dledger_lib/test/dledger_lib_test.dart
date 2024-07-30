import 'package:dledger_lib/dledger_lib.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('integration', () {
    var journalText = '''
2024-07-12 高鐵票
    Liabilities:CreditCard:玉山Pi信用卡
    Expenses:Transportation:PublicService  700.00 TWD
  ''';
    var journal = JournalParser().parseJournal(journalText);
    var statement = IncomeStatementReporter().getIncomeStatement(journal);
    expect(statement.incomes.summarize().expandAccount(1), equals({}));
    var actual = statement.expenses.summarize().expandAccount(1);
    expect(
        actual,
        equals({
          'Expenses': {
            '2024-07-12': const Commodity(700.0, 'TWD', UnitPosition.right)
          }
        }));
  });
  test('integration', () {
    var journalText = '''
2024-07-12 高鐵票
    Liabilities:CreditCard:玉山Pi信用卡
    Expenses:Transportation:PublicService  700.00 TWD
2024-07-12 Lunch
    Liabilities:CreditCard:玉山Pi信用卡
    Expenses:Foods  200.00 TWD
  ''';
    var journal = JournalParser().parseJournal(journalText);
    var statement = IncomeStatementReporter().getIncomeStatement(journal);
    expect(statement.incomes.summarize().expandAccount(1), equals({}));
    var actual = statement.expenses.summarize().expandAccount(1);
    expect(
        actual,
        equals({
          'Expenses': {
            '2024-07-12': const Commodity(900.0, 'TWD', UnitPosition.right),
          }
        }));
  });
}
