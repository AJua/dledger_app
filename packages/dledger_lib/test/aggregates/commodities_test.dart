import 'package:dledger_lib/dledger_lib.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('commodity with same unit', () {
    var commodities = Commodities.empty();
    var c = const Commodity(100, '\$', UnitPosition.left);

    commodities.add(c);

    expect(commodities.all, {c.unit: c});
  });
  test('commodity with same unit', () {
    var commodities = Commodities.empty();
    var c1 = const Commodity(100, '\$', UnitPosition.left);
    var c2 = const Commodity(200, '\$', UnitPosition.left);

    commodities.add(c1);
    commodities.add(c2);

    expect(commodities.all, {c1.unit: c1 + c2});
  });
  test('commodity with same unit', () {
    var commodities = Commodities.empty();
    var c1 = const Commodity(100, '\$', UnitPosition.left);
    var c2 = const Commodity(200, '¥', UnitPosition.right);

    commodities.add(c1);
    commodities.add(c2);

    expect(commodities.all, {c1.unit: c1, c2.unit: c2});
  });
}
