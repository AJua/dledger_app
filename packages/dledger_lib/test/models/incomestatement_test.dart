import 'package:dledger_lib/dledger_lib.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('income statement', () {
    var journalText = r'''
2024-01-01 opening balances         
    assets:checking          $3000  
    equity:start                    

2024-01-03 ! (12345) pay rent
    assets:checking          
    expenses:rent                     $500  
    expenses:subscription:water        $15  
    expenses:subscription:electricity  $15  

; Keeping transactions in date order is optional (but helps error checking).
    ''';
    var parser = JournalParser();
    var journal = parser.parseJournal(journalText);
    var incomeStatement = journal.getIncomeStatement(depth: 1);

    expect(
        incomeStatement.expenses!.all.values,
        equals(
          [
            Statement(const Account(['expenses']), {
              StatementPeriod(DateTime(2024, 1, 3), PeriodType.monthly):
                  Commodities.empty()
                    ..add(const Commodity(530, r'$', UnitPosition.left))
            })
          ],
        ));
  });
}

//FinancialStats:<FinancialStats({Account(expenses)}): Statement(Account(expenses)}), {1/2024: Commodities({$: Commodity(530.0, $, UnitPosition.left)})})})>
