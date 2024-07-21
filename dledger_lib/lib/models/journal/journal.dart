
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

class Transaction {
  DateTime date;
  List<AccountRecord> records;

  Transaction(this.date, this.records);
}

class AccountRecord {
  Account account;
  Commodity commodity;

  AccountRecord(this.account, this.commodity);
}

class Commodity {
  num amount;
  String unit;
  Commodity? exchange;

  Commodity(this.amount, this.unit, {this.exchange});
}

class Account {
  List<String> accountHierarchy;

  Account(this.accountHierarchy);
}