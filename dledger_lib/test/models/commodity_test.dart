import 'package:dledger_lib/models/commodity.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('commodity with same unit', () {
    var c1 = Commodity(100, '\$');
    var c2 = Commodity(200, '\$');
    var actual = c1 + c2;
    expect(actual.amount, 300);
  });
  test('commodity with different unit', () {
    var c1 = Commodity(100, 'USD');
    var c2 = Commodity(200, 'TWD');
    expect(() => c1 + c2, throwsException);
  });
}
