import 'account_record.dart';

class Transaction {
  DateTime date;
  String? description;
  Iterable<AccountRecord> records;

  Transaction(this.date, this.records, {this.description});
}
