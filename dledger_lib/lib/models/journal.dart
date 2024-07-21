import './transaction.dart';

class Journal{
  List<Transaction> _transactions;
  List<Transaction> get transactions => _transactions.toList(growable: false);

  Journal._(this._transactions);

  factory Journal.init(String journalText){
    return Journal._([]);
  }

  addTransaction(Transaction transaction){
    _transactions.add(transaction);
  }

}