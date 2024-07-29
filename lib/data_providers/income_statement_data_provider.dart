import 'package:dledger_app/models/income_statement.dart';
import 'package:dledger_lib/dledger_lib.dart';

class IncomeStatementDataProvider {
  IncomeStatementView get() {
    var journalText = '''
2024-07-12 高鐵票
    Liabilities:CreditCard:玉山Pi信用卡
    Expenses:Transportation:PublicService  700.00 TWD
    
2024-07-12 高鐵票
    Liabilities:CreditCard:玉山Pi信用卡
    Expenses:Rent  700.00 TWD
    
2024-07-12 Lunch
    Liabilities:CreditCard:玉山Pi信用卡
    Expenses:Foods  200.00 TWD
  ''';
    var journal = JournalParser().parseJournal(journalText);
    var statement = IncomeStatementReporter().getIncomeStatement(journal);

    return IncomeStatementView(
        {}, statement.expenses.summarize().expandAccount(3));

    return IncomeStatementView({}, {
      'car': {
        '2024-07-24': const Commodity(100, 'TWD', UnitPosition.right),
        '2024-07-25': const Commodity(100, 'TWD', UnitPosition.right),
        '2024-07-26': const Commodity(100, 'TWD', UnitPosition.right),
      },
      '  *Subscriptions*    ': {
        '2024-07-24': const Commodity(10000000, 'TWD', UnitPosition.right),
        '2024-07-25': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-26': const Commodity(100000, 'TWD', UnitPosition.right),
      },
      '    Gas': {
        '2024-07-24': const Commodity(10000000, 'TWD', UnitPosition.right),
        '2024-07-25': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-26': const Commodity(100000, 'TWD', UnitPosition.right),
      },
      '    Water': {
        '2024-07-24': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-25': const Commodity(100, 'TWD', UnitPosition.right),
        '2024-07-26': const Commodity(100, 'TWD', UnitPosition.right),
      },
      'Amortization': {
        '2024-07-24': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-25': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-26': const Commodity(100000, 'TWD', UnitPosition.right),
      },
      'Transportation': {
        '2024-07-24': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-25': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-26': const Commodity(100000, 'TWD', UnitPosition.right),
      },
      'Social': {
        '2024-07-24': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-25': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-26': const Commodity(100000, 'TWD', UnitPosition.right),
      },
      'Clothes': {
        '2024-07-24': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-25': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-26': const Commodity(100000, 'TWD', UnitPosition.right),
      },
      'a': {
        '2024-07-24': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-25': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-26': const Commodity(100000, 'TWD', UnitPosition.right),
      },
      'b': {
        '2024-07-24': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-25': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-26': const Commodity(100000, 'TWD', UnitPosition.right),
      },
      'c': {
        '2024-07-24': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-25': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-26': const Commodity(100000, 'TWD', UnitPosition.right),
      },
      'd': {
        '2024-07-24': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-25': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-26': const Commodity(100000, 'TWD', UnitPosition.right),
      },
      'e': {
        '2024-07-24': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-25': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-26': const Commodity(100000, 'TWD', UnitPosition.right),
      },
      'f': {
        '2024-07-24': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-25': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-26': const Commodity(100000, 'TWD', UnitPosition.right),
      },
      'g': {
        '2024-07-24': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-25': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-26': const Commodity(100000, 'TWD', UnitPosition.right),
      },
      'h': {
        '2024-07-24': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-25': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-26': const Commodity(100000, 'TWD', UnitPosition.right),
      },
      'i': {
        '2024-07-24': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-25': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-26': const Commodity(100000, 'TWD', UnitPosition.right),
      },
      'j': {
        '2024-07-24': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-25': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-26': const Commodity(100000, 'TWD', UnitPosition.right),
      },
      'k': {
        '2024-07-24': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-25': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-26': const Commodity(100000, 'TWD', UnitPosition.right),
      },
      'l': {
        '2024-07-24': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-25': const Commodity(100000, 'TWD', UnitPosition.right),
        '2024-07-26': const Commodity(100000, 'TWD', UnitPosition.right),
      },
    });
  }
}
