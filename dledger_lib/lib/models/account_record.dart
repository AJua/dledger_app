import './account.dart';
import './commodity.dart';

class AccountRecord {
  final Account account;
  final Commodity commodity;

  AccountRecord(this.account, this.commodity);

  @override
  String toString() {
    return 'Record("account": $account, "commodity": $commodity)';
  }
}
