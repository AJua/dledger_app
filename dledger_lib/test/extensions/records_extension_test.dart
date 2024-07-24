import 'package:dledger_lib/extensions/records_extension.dart';
import 'package:dledger_lib/models/account.dart';
import 'package:dledger_lib/models/account_record.dart';
import 'package:dledger_lib/models/commodity.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  var testingRecords = [
    AccountRecord(
      Account(['expenses', 'interests', 'movies']),
      commodity: Commodity(250, 'TWD'),
    ),
    AccountRecord(
      Account(['expenses', 'interests', 'books']),
      commodity: Commodity(500, 'TWD'),
    ),
    AccountRecord(
      Account(['expenses', 'rent']),
      commodity: Commodity(12000, 'TWD'),
    ),
  ];
  test('group by account with depth=1', () {
    var actual = testingRecords.groupByAccount(depth: 1);
    expect(actual.keys, equals(['interests', 'rent']));
    expect(
        actual['interests']!
            .fold(0.0, (total, a) => total + a.commodity!.amount),
        equals(750));
  });
  test('group by account with depth=2', () {
    var actual = testingRecords.groupByAccount(depth: 2);
    expect(actual.keys, equals(['interests', 'rent', 'movies', 'books']));
    expect(
        actual['interests']!
            .fold(0.0, (total, a) => total + a.commodity!.amount),
        equals(750));
    expect(
        actual['books']!.fold(0.0, (total, a) => total + a.commodity!.amount),
        equals(500));
  });
}
