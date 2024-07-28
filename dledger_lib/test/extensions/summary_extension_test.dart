import 'package:dledger_lib/extensions/summary_extension.dart';
import 'package:dledger_lib/models/account.dart';
import 'package:dledger_lib/models/commodity.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  var someCommodity = const Commodity(1, 'TWD', UnitPosition.right);
  test('expandAccount with depth = 1', () {
    var summary = {
      const Account(['income', 'salary']): {'2024-07-24': someCommodity}
    };
    expect(
      summary.expandAccount(1),
      equals({
        'income': {'2024-07-24': const Commodity(1, 'TWD', UnitPosition.right)}
      }),
    );
  });
  test('expandAccount with depth = 2', () {
    var summary = {
      const Account(['income', 'salary']): {'2024-07-24': someCommodity}
    };
    expect(
      summary.expandAccount(2),
      equals({
        'income': {'2024-07-24': someCommodity},
        '  salary': {'2024-07-24': someCommodity}
      }),
    );
  });
  test('expandAccount with depth = 3', () {
    var summary = {
      const Account(['income', 'salary']): {'2024-07-24': someCommodity}
    };
    expect(
      summary.expandAccount(3),
      equals({
        'income': {'2024-07-24': someCommodity},
        '  salary': {'2024-07-24': someCommodity}
      }),
    );
  });
}
