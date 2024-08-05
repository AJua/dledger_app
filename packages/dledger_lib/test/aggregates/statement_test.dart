import 'package:dledger_lib/dledger_lib.dart';
import 'package:dledger_lib/src/aggregates/statement.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('different upper account cannot compare', () {
    var statement1 = const Statement(Account(['expenses', 'clothes', 'jeans']), {});
    var statement2 = const Statement(Account(['expenses', 'foods', 'lunch']), {});
    expect(() => statement1.compareTo(statement2), throwsException);
  });
  test('add a single posting', () {
    var statement1 = Statement(const Account(['expenses']), {
      StatementPeriod(DateTime(2024), PeriodType.yearly): Commodities.empty()
        ..add(const Commodity(100, 'TWD', UnitPosition.right))
    });
    var statement2 = Statement(const Account(['expenses']), {
      StatementPeriod(DateTime(2024), PeriodType.yearly): Commodities.empty()
        ..add(const Commodity(200, 'TWD', UnitPosition.right))
    });
    expect(statement1.compareTo(statement2), equals(-1));
  });
  test('add a single posting', () {
    var statement1 = Statement(const Account(['expenses']), {
      StatementPeriod(DateTime(2024), PeriodType.yearly): Commodities.empty()
        ..add(const Commodity(100, 'TWD', UnitPosition.right))
        ..add(const Commodity(100, 'TWD', UnitPosition.right))
    });
    var statement2 = Statement(const Account(['expenses']), {
      StatementPeriod(DateTime(2024), PeriodType.yearly): Commodities.empty()
        ..add(const Commodity(200, 'TWD', UnitPosition.right))
    });
    expect(statement1.compareTo(statement2), equals(0));
  });
  test('add a single posting', () {
    var statement1 = Statement(const Account(['expenses']), {
      StatementPeriod(DateTime(2024), PeriodType.yearly): Commodities.empty()
        ..add(const Commodity(100, 'TWD', UnitPosition.right)),
      StatementPeriod(DateTime(2025), PeriodType.yearly): Commodities.empty()
        ..add(const Commodity(200, 'TWD', UnitPosition.right))
    });
    var statement2 = Statement(const Account(['expenses']), {
      StatementPeriod(DateTime(2024), PeriodType.yearly): Commodities.empty()
        ..add(const Commodity(200, 'TWD', UnitPosition.right))
    });
    expect(statement1.compareTo(statement2), equals(1));
  });
}
