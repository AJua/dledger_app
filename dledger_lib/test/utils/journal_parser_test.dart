import 'package:dledger_lib/utils/journal_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
    expect(transaction.records.length, 3);
    expect(
      transaction.records
          .fold(0.0, (sumUp, record) => sumUp + record.commodity!.amount),
      0,
    );
  });
  test('parseAccount', () {
    var parser = JournalParser();
    var account = parser.parseAccount('Assets:Cash');
    expect(account.category, 'Assets');
  });
  test('parseRecord', () {
    var parser = JournalParser();
    var record = parser.parseRecord('  Assets:Cash   100.00 TWD');
    expect(record.account.hierarchy.join(','), ['Assets', 'Cash'].join(','));
    expect(record.commodity!.amount, 100);
    expect(record.commodity!.unit, 'TWD');
  });
  group('parseCommodity', () {
    test('input value include ISO currency', () {
      var parser = JournalParser();
      var commodity = parser.parseCommodity('100.00 TWD');
      expect(commodity!.amount, 100);
      expect(commodity!.unit, 'TWD');
    });
    test('input value is negative', () {
      var parser = JournalParser();
      var commodity = parser.parseCommodity('-5,000 YEN');
      expect(commodity!.amount, -5000);
      expect(commodity!.unit, 'YEN');
    });
    test('input value contains dollar symbol', () {
      var parser = JournalParser();
      var commodity = parser.parseCommodity('\$1');
      expect(commodity!.amount, 1);
      expect(commodity!.unit, r'$');
    });
  });
}
