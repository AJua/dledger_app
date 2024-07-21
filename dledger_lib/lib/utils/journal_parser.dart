import 'package:dledger_lib/models/commodity.dart';
import 'package:dledger_lib/models/journal.dart';
import 'package:dledger_lib/models/transaction.dart';

import '../models/account.dart';
import '../models/account_record.dart';

class JournalParser {
  Journal parseJournal(String journalText) {
    var journal = Journal.init();
    var transactionText = List<String>.empty(growable: true);
    journalText.split('\n').forEach((lineText) {
      var commentRegex = RegExp(r'(.*);.*');
      var firstMatch = commentRegex.firstMatch(lineText);
      var input = (firstMatch == null) ? lineText : firstMatch![1]!;

      var emptyRegex = RegExp(r'^\s*$');
      if (emptyRegex.firstMatch(input) != null) {
        return;
      }

      var dateRegex = RegExp(r'^(\d{4}\-\d{1,2}\-\d{1,2})');
      var match = dateRegex.firstMatch(input);
      if (match == null && transactionText.isNotEmpty) {
        transactionText.add(input);
        return;
      }
      if (transactionText.isNotEmpty) {
        journal.addTransaction(parseTransaction(transactionText));
        transactionText = List<String>.empty(growable: true);
      }
      transactionText.add(input);
    });
    if (transactionText.isNotEmpty) {
      journal.addTransaction(parseTransaction(transactionText));
    }

    return journal;
  }

  Transaction parseTransaction(List<String> txnText) {
    var transactionRexExp = RegExp(r'^(\S+)\s+(.*)');
    var firstMath = transactionRexExp.firstMatch(txnText[0])!;
    var records = txnText.sublist(1).map((t) => parseRecord(t));
    var recordWithoutCommodity =
        records.where((r) => r.commodity == null).firstOrNull;
    if (recordWithoutCommodity != null) {
      var balancing = records.fold(
        0.0,
        (previousValue, record) =>
            previousValue + (record.commodity?.amount ?? 0.0),
      );
      var unit = records
          .firstWhere((r) => r.commodity != null && r.commodity!.cost == null)
          .commodity!
          .unit;
      recordWithoutCommodity.commodity = Commodity(0.0 - balancing, unit);
    }
    return Transaction(
      DateTime.parse(firstMath[1]!),
      recordWithoutCommodity == null
          ? records
          : [
              recordWithoutCommodity,
              ...records.where((r) => r.commodity != null).toList()
            ],
      description: firstMath[2]!.trim(),
    );
  }

  AccountRecord parseRecord(String recordText) {
    var accountRegExp = RegExp(r'^\s+([\ \w:]+\w)\s{2,}(.*)');
    var firstMatch = accountRegExp.firstMatch(recordText)!;

    var accountText = firstMatch[1]!;
    var commodityText = firstMatch[2]!;

    return AccountRecord(parseAccount(accountText),
        commodity: parseCommodity(commodityText));
  }

  Account parseAccount(String recordText) {
    return Account(recordText.split(':'));
  }

  Commodity? parseCommodity(String commodityText) {
    if (RegExp(r'^\s*$').firstMatch(commodityText) != null) {
      return null;
    }

    /// $100.00
    var symbolExp = RegExp(r'^([^\s\d\-]+)(\-?[\d\.,]+)');
    var symbolMatch = symbolExp.firstMatch(commodityText);
    if (symbolMatch != null) {
      var amountText1 = symbolMatch[2]!.replaceAll(',', '');
      return Commodity(double.parse(amountText1), symbolMatch[1]!);
    }

    /// 100.00 TWD
    var regExp = RegExp(r'(\-?[\d\.,]+)\s+(\w+)');
    var firstMatch = regExp.firstMatch(commodityText);

    var amountText2 = firstMatch![1]!.replaceAll(',', '');
    var unitText = firstMatch[2]!;
    return Commodity(double.parse(amountText2), unitText);
  }
}
