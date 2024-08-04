import 'package:dledger_lib/dledger_lib.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parseJournal', () {
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
    expect(journal.transactions.length, 2);
  });
  test('parseTransaction', () {
    var transactionText = [
      r'2024-01-01 opening balances   ',
      r'    assets:savings           $10000',
      r'    liabilities:credit card  $-500',
      r'    equity:start             ',
    ];
    var parser = JournalParser();
    var transaction = parser.parseTransaction(transactionText);
    expect(transaction.date, DateTime(2024, 1, 1));
    expect(transaction.description, 'opening balances');
    expect(transaction.postings.length, 3);
    expect(
      transaction.postings.fold(0.0, (sumUp, record) => sumUp + record.commodity.amount),
      0,
    );
  });
  test('parseAccount', () {
    var parser = JournalParser();
    var account = parser.parseAccount('Assets:Cash');
    expect(account.category, 'Assets');
  });
  group('parsePosting', () {
    test('posting with Commodity', () {
      var parser = JournalParser();
      var record = parser.parsePosting('  Assets:Cash   100.00 TWD');
      expect(record.account.hierarchy.join(','), ['Assets', 'Cash'].join(','));
      expect(record.commodity, equals(const Commodity(100, 'TWD', UnitPosition.right)));
    });
    test('posting with UTF-8 character', () {
      var parser = JournalParser();
      var record = parser.parsePosting('  Assets:Bank:玉山銀行   -200.00 TWD ');
      expect(record.account, const Account(['Assets', 'Bank', '玉山銀行']));
      expect(record.commodity, equals(const Commodity(-200, 'TWD', UnitPosition.right)));
    });
    test('postingWithoutCommodity', () {
      var parser = JournalParser();
      var record = parser.parsePosting('  Assets:Cash');
      expect(record.account, const Account(['Assets', 'Cash']));
      expect(record.commodity, isNull);
    });
  });
  group('parseCommodity', () {
    test('input value include ISO currency', () {
      var parser = JournalParser();
      var commodity = parser.parseCommodity('100.00 TWD');
      expect(commodity, equals(const Commodity(100, 'TWD', UnitPosition.right)));
    });
    test('input value is negative', () {
      var parser = JournalParser();
      var commodity = parser.parseCommodity('-5,000 YEN');
      expect(commodity!.amount, -5000);
      expect(commodity.unit, 'YEN');
    });
    test('input value contains dollar symbol', () {
      var parser = JournalParser();
      var commodity = parser.parseCommodity('\$1');
      expect(commodity!.amount, 1);
      expect(commodity.unit, r'$');
    });
  });
}
