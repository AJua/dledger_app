import 'package:dledger_lib/dledger_lib.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Commodity should be aggregated', () {
    var someCommodity = const Commodity(1, 'TWD', UnitPosition.right);
    var anotherCommodity = const Commodity(2, 'TWD', UnitPosition.right);
    test('expandAccount with depth = 1', () {
      var summary = {
        const Account(['income', 'salary']): {'2024-07-24': someCommodity},
        const Account(['income', 'bonus']): {'2024-07-24': anotherCommodity},
      };
      expect(
        summary.expandAccount(1),
        equals({
          'income': {'2024-07-24': someCommodity + anotherCommodity}
        }),
      );
    });
    test('expandAccount with depth = 1', () {
      var summary = {
        const Account(['income', 'salary']): {'2024-07-24': someCommodity},
        const Account(['income', 'bonus']): {'2024-07-25': anotherCommodity},
      };
      expect(
        summary.expandAccount(1),
        equals({
          'income': {
            '2024-07-24': someCommodity,
            '2024-07-25': anotherCommodity,
          },
        }),
      );
    });
    test('expandAccount with depth = 2', () {
      var summary = {
        const Account(['income', 'salary']): {'2024-07-24': someCommodity},
        const Account(['income', 'bonus']): {'2024-07-24': anotherCommodity},
      };
      expect(
        summary.expandAccount(2),
        equals({
          'income': {
            '2024-07-24': someCommodity + anotherCommodity,
          },
          '  salary': {
            '2024-07-24': someCommodity,
          },
          '  bonus': {
            '2024-07-24': anotherCommodity,
          },
        }),
      );
    });
  });
  group('depth', () {
    var someCommodity = const Commodity(1, 'TWD', UnitPosition.right);
    test('expandAccount with depth = 1', () {
      var summary = {
        const Account(['income', 'salary']): {'2024-07-24': someCommodity}
      };
      expect(
        summary.expandAccount(1),
        equals({
          'income': {
            '2024-07-24': const Commodity(1, 'TWD', UnitPosition.right)
          }
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
  });
}
