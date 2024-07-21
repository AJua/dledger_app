import 'package:dledger_lib/models/commodity.dart';

import '../models/account.dart';
import '../models/account_record.dart';

class JournalParser {
  //Transaction parseTransaction(String txnText){
  //  return Transaction(date, records);
  //}

  AccountRecord parseRecord(String recordText) {
    var accountRegExp = RegExp(r'^\s+([\w:]+)\s{2,}(.*)');
    var firstMatch = accountRegExp.firstMatch(recordText);

    var accountText = firstMatch![1]!;
    var commodityText = firstMatch![2]!;

    return AccountRecord(
        parseAccount(accountText), parseCommodity(commodityText));
  }

  Account parseAccount(String recordText) {
    return Account(recordText.split(':'));
  }

  Commodity parseCommodity(String commodityText) {
    var symbolExp = RegExp(r'^([^\s\d]+)([\d\.,]+)');
    var symbolMatch = symbolExp.firstMatch(commodityText);
    if (symbolMatch != null) {
      return Commodity(double.parse(symbolMatch![2]!), symbolMatch![1]!);
    }

    var regExp = RegExp(r'([\d\.,]+)\s+(\w+)');
    var firstMatch = regExp.firstMatch(commodityText);

    var amountText = firstMatch![1]!;
    var unitText = firstMatch![2]!;
    return Commodity(double.parse(amountText), unitText);
  }
}
