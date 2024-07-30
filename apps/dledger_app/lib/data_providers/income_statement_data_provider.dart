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
  }
}
