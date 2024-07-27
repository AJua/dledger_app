import 'package:dledger_lib/models/account.dart';
import 'package:dledger_lib/models/commodity.dart';
import 'package:dledger_lib/models/posting.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('commodity with same unit', () {
    var p1 = Posting(
      DateTime(2024, 7, 25),
      Account(['expenses']),
      const Commodity(1.0, 'TWD', UnitPosition.right),
    );
    var p2 = Posting(
      DateTime(2024, 7, 25),
      Account(['expenses']),
      const Commodity(2.0, 'TWD', UnitPosition.right),
    );
    var actual = p1 + p2;
    expect(actual.commodity, const Commodity(3.0, 'TWD', UnitPosition.right));
  });
}
