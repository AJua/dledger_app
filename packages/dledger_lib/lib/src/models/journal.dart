import 'package:flutter/foundation.dart';

import 'transaction.dart';

class Journal with ChangeNotifier, DiagnosticableTreeMixin {
  List<Transaction> _transactions;

  List<Transaction> get transactions => _transactions.toList(growable: false);

  Journal._(this._transactions);

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('transactions', _transactions.join(', ')));
  }

  factory Journal.init() {
    return Journal._([]);
  }

  addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }

  reload(List<Transaction> transactions) {
    _transactions = transactions;
    notifyListeners();
  }
}
