import 'posting.dart';

class Transaction {
  DateTime date;
  String? description;
  Iterable<Posting> records;

  Transaction(this.date, this.records, {this.description});
}
