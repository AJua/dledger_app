import './account.dart';
import './commodity.dart';

class Posting {
  final Account account;
  Commodity? commodity;

  get primaryAccount => account.hierarchy[0].toLowerCase();

  Posting(this.account, {this.commodity});

  @override
  String toString() {
    return 'Posting("account": $account, "commodity": $commodity)';
  }
}
