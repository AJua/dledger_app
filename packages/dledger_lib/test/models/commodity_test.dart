import 'package:dledger_lib/dledger_lib.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('commodity with same unit', () {
    var c1 = const Commodity(100, '\$', UnitPosition.left);
    var c2 = const Commodity(200, '\$', UnitPosition.left);

    expect(c1 + c2, const Commodity(300, '\$', UnitPosition.left));
  });
  test('commodity with different unit', () {
    var c1 = const Commodity(100, 'USD', UnitPosition.right);
    var c2 = const Commodity(200, 'TWD', UnitPosition.right);

    expect(() => c1 + c2, throwsException);
  });
  group('amount display', () {
    test(r'using money symbol like $, €, ¥', () {
      const commodity = Commodity(1, r'$', UnitPosition.left);
      expect(commodity.amountFormat(isDisplayUnit: true), r'$1.0');
    });
    test('using ISO currency', () {
      const commodity = Commodity(1, r'USD', UnitPosition.right);
      expect(commodity.amountFormat(isDisplayUnit: true), '1.0 USD');
    });
  });
}
