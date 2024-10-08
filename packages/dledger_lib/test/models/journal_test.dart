import 'package:dledger_lib/dledger_lib.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('', () {
    var journalText = r'''
2024-01-01 opening balances         ; At the start, declare pre-existing balances this way.
    assets:savings          $10000  ; Account names can be anything. lower case is easy to type.
    assets:checking          $1000  ; assets, liabilities, equity, revenues, expenses are common.
    liabilities:credit card  $-500  ; liabilities, equity, revenues balances are usually negative.
    equity:start                    ; One amount can be left blank. $-10500 is inferred here.
                                    ; Some of these accounts we didn't declare above,
                                    ; so -s/--strict would complain.

2024-01-03 ! (12345) pay rent
    ; Additional transaction comment lines, indented.
    ; There can be a ! or * after the date meaning "pending" or "cleared".
    ; There can be a parenthesised (code) after the date/status.
                                    ; Amounts' sign shows direction of flow.
    assets:checking          $-500  ; Minus means removed from this account (credit).
    expenses:rent             $500  ; Plus means added to this account (debit).

; Keeping transactions in date order is optional (but helps error checking).
    ''';
    var parser = JournalParser();
    var journal = parser.parseJournal(journalText);
    var incomeStatement = journal.getIncomeStatement(depth: 1);
    expect(incomeStatement.incomes, equals(null));
    expect(incomeStatement.expenses?.all.length, equals(1));
  });
}
