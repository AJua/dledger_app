import 'package:dledger_lib/extensions/records_extension.dart';
import 'package:dledger_lib/models/account.dart';
import 'package:dledger_lib/models/commodity.dart';
import 'package:dledger_lib/models/posting.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  var testingRecords = [
    Posting(
      DateTime(2024, 7, 28),
      Account(['expenses', 'interests', 'movies']),
      Commodity(250, 'TWD'),
    ),
    Posting(
      DateTime(2024, 7, 28),
      Account(['expenses', 'interests', 'books']),
      Commodity(500, 'TWD'),
    ),
    Posting(
      DateTime(2024, 7, 28),
      Account(['expenses', 'rent']),
      Commodity(12000, 'TWD'),
    ),
  ];
  test('group by account with depth=1', () {
    var actual = testingRecords.groupByAccount(depth: 1);
    expect(actual.keys, equals(['interests', 'rent']));
    expect(
        actual['interests']!
            .fold(0.0, (total, a) => total + a.commodity.amount),
        equals(750));
  });
  test('group by account with depth=2', () {
    var actual = testingRecords.groupByAccount(depth: 2);
    expect(actual.keys, equals(['interests', 'rent', 'movies', 'books']));
    expect(
        actual['interests']!
            .fold(0.0, (total, a) => total + a.commodity.amount),
        equals(750));
    expect(actual['books']!.fold(0.0, (total, a) => total + a.commodity.amount),
        equals(500));
  });
}
