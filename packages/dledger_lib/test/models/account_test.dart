import 'package:dledger_lib/dledger_lib.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('account', () {
    var account1 = const Account(['income', 'salary']);
    var account2 = const Account(['income', 'salary']);
    expect(account1, equals(account2));
  });
  test('account', () {
    var account1 = const Account(['income', 'salary']);
    var account2 = const Account(['income', 'bonus']);
    expect(account1 == account2, isFalse);
  });
}
