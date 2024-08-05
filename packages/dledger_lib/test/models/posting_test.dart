import 'package:dledger_lib/dledger_lib.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('tree', () {
    var posting = Posting(DateTime(2024), const Account(['income', 'salary']),
        const Commodity(100, 'TWD', UnitPosition.right));
    expect(posting.tree, [
      Posting(DateTime(2024), const Account(['income', 'salary']),
          const Commodity(100, 'TWD', UnitPosition.right)),
      Posting(DateTime(2024), const Account(['income']),
          const Commodity(100, 'TWD', UnitPosition.right)),
    ]);
  });
}
