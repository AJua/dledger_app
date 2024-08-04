import 'package:dledger_lib/dledger_lib.dart';
import 'package:dledger_lib/src/aggregates/statements.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('commodity with same unit', () {
    var statements = Statements.empty(PeriodType.daily);
    var c = const Commodity(100, '\$', UnitPosition.left);
    var p = Posting(DateTime(2024, 1, 24), const Account(['expense', 'foods']), c);

    statements.add(p);

    expect({
      StatementPeriod(DateTime(2024, 8, 1), PeriodType.monthly),
      StatementPeriod(DateTime(2024, 8, 3), PeriodType.monthly)
    }, equals({StatementPeriod(DateTime(2024, 8, 2), PeriodType.monthly)}));
  });
}
