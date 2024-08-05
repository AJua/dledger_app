import 'package:dledger_lib/dledger_lib.dart';
import 'package:dledger_lib/src/aggregates/statement.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('add a single posting', () {
    var statements = FinancialStats.empty(PeriodType.daily);
    const account = Account(['expense', 'foods']);
    const commodity = Commodity(100, '\$', UnitPosition.left);
    var p = Posting(
      DateTime(2024, 1, 24),
      account,
      commodity,
    );

    statements.add(p);

    expect(
      statements.all,
      equals({
        account: Statement(account,
            {StatementPeriod(p.date, PeriodType.daily): Commodities.empty()..add(commodity)})
      }),
    );
  });
  test('add 2 posting with different accounts', () {
    var statements = FinancialStats.empty(PeriodType.daily);
    const account1 = Account(['expense', 'foods']);
    const account2 = Account(['expense', 'clothes']);
    const commodity = Commodity(100, '\$', UnitPosition.left);
    var p1 = Posting(DateTime(2024, 1, 24), account1, commodity);
    var p2 = Posting(DateTime(2024, 1, 24), account2, commodity);

    statements.add(p1);
    statements.add(p2);

    expect(
      statements.all,
      equals({
        account1: Statement(account1,
            {StatementPeriod(p1.date, PeriodType.daily): Commodities.empty()..add(commodity)}),
        account2: Statement(account2,
            {StatementPeriod(p2.date, PeriodType.daily): Commodities.empty()..add(commodity)})
      }),
    );
  });
  test('add 2 posting with same account and same date', () {
    var statements = FinancialStats.empty(PeriodType.daily);
    const account = Account(['expense', 'foods']);
    const commodity1 = Commodity(100, '\$', UnitPosition.left);
    const commodity2 = Commodity(200, '\$', UnitPosition.left);
    var p1 = Posting(DateTime(2024, 1, 24), account, commodity1);
    var p2 = Posting(DateTime(2024, 1, 24), account, commodity2);

    statements.add(p1);
    statements.add(p2);

    expect(
      statements.all,
      equals({
        account: Statement(account, {
          StatementPeriod(p1.date, PeriodType.daily): Commodities.empty()
            ..add(commodity1)
            ..add(commodity2),
        }),
      }),
    );
  });
  test('add 2 posting with same account and different date', () {
    var statements = FinancialStats.empty(PeriodType.daily);
    const account = Account(['expense', 'foods']);
    const commodity1 = Commodity(100, '\$', UnitPosition.left);
    const commodity2 = Commodity(200, '\$', UnitPosition.left);
    var p1 = Posting(DateTime(2024, 1, 24), account, commodity1);
    var p2 = Posting(DateTime(2024, 1, 25), account, commodity2);

    statements.add(p1);
    statements.add(p2);

    expect(
      statements.all,
      equals({
        account: Statement(account, {
          StatementPeriod(p1.date, PeriodType.daily): Commodities.empty()..add(commodity1),
          StatementPeriod(p2.date, PeriodType.daily): Commodities.empty()..add(commodity2),
        }),
      }),
    );
  });
  test('add 2 posting with different account and different date', () {
    var statements = FinancialStats.empty(PeriodType.daily);
    const account1 = Account(['expense', 'foods']);
    const account2 = Account(['expense', 'clothes']);
    const commodity1 = Commodity(100, '\$', UnitPosition.left);
    const commodity2 = Commodity(200, '\$', UnitPosition.left);
    var p1 = Posting(DateTime(2024, 1, 24), account1, commodity1);
    var p2 = Posting(DateTime(2024, 1, 25), account2, commodity2);

    statements.add(p1);
    statements.add(p2);

    expect(
      statements.all,
      equals({
        account1: Statement(account1, {
          StatementPeriod(p1.date, PeriodType.daily): Commodities.empty()..add(commodity1),
          StatementPeriod(p2.date, PeriodType.daily): Commodities.empty(),
        }),
        account2: Statement(account2, {
          StatementPeriod(p1.date, PeriodType.daily): Commodities.empty(),
          StatementPeriod(p2.date, PeriodType.daily): Commodities.empty()..add(commodity2),
        }),
      }),
    );
  });
}
