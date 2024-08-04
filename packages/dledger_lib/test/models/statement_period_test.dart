import 'package:dledger_lib/dledger_lib.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('same monthly statement period', () {
    var period1 = StatementPeriod(DateTime(2024, 8, 1), PeriodType.monthly);
    var period2 = StatementPeriod(DateTime(2024, 8, 2), PeriodType.monthly);
    expect(period1, equals(period2));
  });
  test('different monthly statement period', () {
    var period1 = StatementPeriod(DateTime(2024, 8, 1), PeriodType.monthly);
    var period2 = StatementPeriod(DateTime(2024, 9, 2), PeriodType.monthly);
    expect(period1, isNot(equals(period2)));
  });
  group('Set follows the same comparison rule', () {
    test('same period', () {
      expect(
        {
          StatementPeriod(DateTime(2024, 8, 1), PeriodType.monthly),
          StatementPeriod(DateTime(2024, 8, 3), PeriodType.monthly),
        },
        equals(
          {StatementPeriod(DateTime(2024, 8, 2), PeriodType.monthly)},
        ),
      );
    });
    test('different period', () {
      expect(
        {
          StatementPeriod(DateTime(2024, 8, 1), PeriodType.monthly),
          StatementPeriod(DateTime(2024, 8, 3), PeriodType.monthly),
        },
        isNot(equals(
          {StatementPeriod(DateTime(2024, 9, 2), PeriodType.monthly)},
        )),
      );
    });
  });
}
