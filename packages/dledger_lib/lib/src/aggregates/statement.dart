import 'package:dledger_lib/dledger_lib.dart';

class Statement implements Comparable<Statement> {
  final Account _account;

  Account get account => _account;

  final Map<StatementPeriod, Commodities> _details;

  Statement(this._account, this._details);

  @override
  int compareTo(Statement other) {
    if (!_isComparable(other)) {
      throw Exception('Statement comparison need have same upper accounts');
    }
    return _details.values.fold(0.0, (v, commodities) => v + commodities.totalAmount).compareTo(
        other._details.values.fold(0.0, (v, commodities) => v + commodities.totalAmount));
  }

  bool _isComparable(Statement other) {
    return account.upperAccounts == other.account.upperAccounts;
  }
}
