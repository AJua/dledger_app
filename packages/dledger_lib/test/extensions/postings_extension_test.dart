import 'package:dledger_lib/dledger_lib.dart';
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
  group('summarize', () {
    test('1 account and 1 posting', () {
      var someAccount = const Account(['expenses', 'interests', 'movies']);
      var testingRecords = [
        Posting(
          DateTime(2024, 7, 28),
          someAccount,
          const Commodity(250, 'TWD', UnitPosition.right),
        ),
      ];
      var actual = testingRecords.summarize();
      expect(
          actual,
          equals({
            someAccount: {
              '2024-07-28': const Commodity(250, 'TWD', UnitPosition.right)
            }
          }));
    });
    test('1 account and 2 posting on the same day', () {
      var someAccount = const Account(['expenses', 'interests', 'movies']);
      var testingRecords = [
        Posting(
          DateTime(2024, 7, 28),
          someAccount,
          const Commodity(250, 'TWD', UnitPosition.right),
        ),
        Posting(
          DateTime(2024, 7, 28),
          someAccount,
          const Commodity(250, 'TWD', UnitPosition.right),
        ),
      ];
      var actual = testingRecords.summarize();
      expect(
          actual,
          equals({
            someAccount: {
              '2024-07-28': const Commodity(500, 'TWD', UnitPosition.right)
            }
          }));
    });
    test('1 account and 2 posting on the different day', () {
      var someAccount = const Account(['expenses', 'interests', 'movies']);
      var testingRecords = [
        Posting(
          DateTime(2024, 7, 28),
          someAccount,
          const Commodity(250, 'TWD', UnitPosition.right),
        ),
        Posting(
          DateTime(2024, 7, 29),
          someAccount,
          const Commodity(250, 'TWD', UnitPosition.right),
        ),
      ];
      var actual = testingRecords.summarize();
      expect(
          actual,
          equals({
            someAccount: {
              '2024-07-28': const Commodity(250, 'TWD', UnitPosition.right),
              '2024-07-29': const Commodity(250, 'TWD', UnitPosition.right),
            }
          }));
    });
    test('2 accounts on  the same day', () {
      var someAccount = const Account(['expenses', 'interests', 'movies']);
      var anotherAccount = const Account(['expenses', 'interests', 'music']);
      var testingRecords = [
        Posting(
          DateTime(2024, 7, 28),
          someAccount,
          const Commodity(250, 'TWD', UnitPosition.right),
        ),
        Posting(
          DateTime(2024, 7, 28),
          anotherAccount,
          const Commodity(150, 'TWD', UnitPosition.right),
        ),
      ];
      var actual = testingRecords.summarize();
      expect(
          actual,
          equals({
            someAccount: {
              '2024-07-28': const Commodity(250, 'TWD', UnitPosition.right)
            },
            anotherAccount: {
              '2024-07-28': const Commodity(150, 'TWD', UnitPosition.right)
            }
          }));
    });
    test('2 accounts on the same day', () {
      var someAccount = const Account(['expenses', 'interests', 'movies']);
      var anotherAccount = const Account(['expenses', 'interests', 'music']);
      var testingRecords = [
        Posting(
          DateTime(2024, 7, 28),
          someAccount,
          const Commodity(250, 'TWD', UnitPosition.right),
        ),
        Posting(
          DateTime(2024, 7, 29),
          anotherAccount,
          const Commodity(150, 'TWD', UnitPosition.right),
        ),
      ];
      var actual = testingRecords.summarize();
      expect(
          actual,
          equals({
            someAccount: {
              '2024-07-28': const Commodity(250, 'TWD', UnitPosition.right)
            },
            anotherAccount: {
              '2024-07-29': const Commodity(150, 'TWD', UnitPosition.right)
            }
          }));
    });
  });
}
