import 'package:dledger_lib/extensions/records_extension.dart';
import 'package:dledger_lib/models/account.dart';
import 'package:dledger_lib/models/commodity.dart';
import 'package:dledger_lib/models/posting.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('groupByAccount', () {
    var testingRecords = [
      Posting(
        DateTime(2024, 7, 28),
        const Account(['expenses', 'interests', 'movies']),
        const Commodity(250, 'TWD', UnitPosition.right),
      ),
      Posting(
        DateTime(2024, 7, 28),
        const Account(['expenses', 'interests', 'books']),
        const Commodity(500, 'TWD', UnitPosition.right),
      ),
      Posting(
        DateTime(2024, 7, 28),
        const Account(['expenses', 'rent']),
        const Commodity(12000, 'TWD', UnitPosition.right),
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
      expect(
          actual['books']!.fold(0.0, (total, a) => total + a.commodity.amount),
          equals(500));
    });
  });
  test('summarize', () {
    var testingRecords = [
      Posting(
        DateTime(2024, 7, 28),
        const Account(['expenses', 'interests', 'movies']),
        const Commodity(250, 'TWD', UnitPosition.right),
      ),
    ];
    var actual = testingRecords.summarize();
    expect(
        actual,
        equals({
          'expenses:interests:movies': {
            '2024-07-28': const Commodity(250, 'TWD', UnitPosition.right)
          }
        }));
  });
  test('summarize', () {
    var testingRecords = [
      Posting(
        DateTime(2024, 7, 28),
        const Account(['expenses', 'interests', 'movies']),
        const Commodity(250, 'TWD', UnitPosition.right),
      ),
      Posting(
        DateTime(2024, 7, 28),
        const Account(['expenses', 'interests', 'movies']),
        const Commodity(250, 'TWD', UnitPosition.right),
      ),
    ];
    var actual = testingRecords.summarize();
    expect(
        actual,
        equals({
          'expenses:interests:movies': {
            '2024-07-28': const Commodity(500, 'TWD', UnitPosition.right)
          }
        }));
  });
  test('summarize', () {
    var testingRecords = [
      Posting(
        DateTime(2024, 7, 28),
        const Account(['expenses', 'interests', 'movies']),
        const Commodity(250, 'TWD', UnitPosition.right),
      ),
      Posting(
        DateTime(2024, 7, 28),
        const Account(['expenses', 'interests', 'music']),
        const Commodity(150, 'TWD', UnitPosition.right),
      ),
    ];
    var actual = testingRecords.summarize();
    expect(
        actual,
        equals({
          'expenses:interests:movies': {
            '2024-07-28': const Commodity(250, 'TWD', UnitPosition.right)
          },
          'expenses:interests:music': {
            '2024-07-28': const Commodity(150, 'TWD', UnitPosition.right)
          }
        }));
  });
}
