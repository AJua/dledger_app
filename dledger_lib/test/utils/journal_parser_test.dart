import 'package:dledger_lib/utils/journal_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parseAccount', () {
    var parser = JournalParser();
    var account = parser.parseAccount('Assets:Cash');
    expect(account.category, 'Assets');
  });
  test('parseRecord', () {
    var parser = JournalParser();
    var record = parser.parseRecord('  Assets:Cash   100.00 TWD');
    expect(record.account.hierarchy.join(','), ['Assets', 'Cash'].join(','));
    expect(record.commodity.amount, 100);
    expect(record.commodity.unit, 'TWD');
  });
  group('parseCommodity', () {
    test('adds one to input values', () {
      var parser = JournalParser();
      var commodity = parser.parseCommodity('100.00 TWD');
      expect(commodity.amount, 100);
      expect(commodity.unit, 'TWD');
    });
    test('adds one to input values', () {
      var parser = JournalParser();
      var commodity = parser.parseCommodity('1 House');
      expect(commodity.amount, 1);
      expect(commodity.unit, 'House');
    });
    test('adds one to input values', () {
      var parser = JournalParser();
      var commodity = parser.parseCommodity('\$1');
      expect(commodity.amount, 1);
      expect(commodity.unit, r'$');
    });
  });
}
