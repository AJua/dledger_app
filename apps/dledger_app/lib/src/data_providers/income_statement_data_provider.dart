import 'package:dledger_app/src/models/income_statement.dart';
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
    
2024-07-13 Lunch
    Liabilities:CreditCard:玉山Pi信用卡
    Expenses:Foods  200.00 TWD
    
2024-07-14 Lunch
    Liabilities:CreditCard:玉山Pi信用卡
    Expenses:Clothes  200.00 TWD
    
2024-07-15 Lunch
    Liabilities:CreditCard:玉山Pi信用卡
    Expenses:Cosmetics  200.00 TWD
    
2024-07-15 Lunch
    Liabilities:CreditCard:玉山Pi信用卡
    Expenses:Electronics:PC  200.00 TWD
    
2024-07-15 Lunch
    Liabilities:CreditCard:玉山Pi信用卡
    Expenses:Interest  200.00 TWD
    
2024-07-15 Lunch
    Liabilities:CreditCard:玉山Pi信用卡
    Expenses:Subscriptions:Water  200.00 TWD
    
2024-07-15 Lunch
    Liabilities:CreditCard:玉山Pi信用卡
    Expenses:Subscriptions:Electricity  200.00 TWD
  ''';
    var journal = JournalParser().parseJournal(journalText);
    var statement = IncomeStatementReporter().getIncomeStatement(journal);

    return IncomeStatementView(
        {}, statement.expenses.summarize().expandAccount(3));
  }
}
