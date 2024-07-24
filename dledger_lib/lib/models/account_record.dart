import './account.dart';
import './commodity.dart';

class AccountRecord {
  final Account account;
  Commodity? commodity;

  get primaryAccount => account.hierarchy[0].toLowerCase();

  AccountRecord(this.account, {this.commodity});

  @override
  String toString() {
    return 'Record("account": $account, "commodity": $commodity)';
  }
}
