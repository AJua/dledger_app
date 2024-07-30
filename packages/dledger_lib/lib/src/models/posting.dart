import './account.dart';
import 'commodity.dart';

class Posting {
  final DateTime date;
  final String? description;
  final Account account;
  final Commodity commodity;

  get primaryAccount => account.hierarchy[0].toLowerCase();

  Posting(this.date, this.account, this.commodity, {this.description});
}
