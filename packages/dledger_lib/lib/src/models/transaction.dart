import 'posting.dart';

class Transaction {
  DateTime date;
  String? description;
  Iterable<Posting> postings;

  Transaction(this.date, this.postings, {this.description});
}
