import 'package:dledger_lib/models/commodity.dart';
import 'package:dledger_lib/models/journal.dart';
import 'package:dledger_lib/models/transaction.dart';

import '../models/account.dart';
import '../models/posting.dart';
import '../models/posting_dto.dart';

class JournalParser {
  Journal parseJournal(String journalText) {
    var journal = Journal.init();
    var transactionText = List<String>.empty(growable: true);
    journalText.split('\n').forEach((lineText) {
      var commentRegex = RegExp(r'(.*);.*');
      var firstMatch = commentRegex.firstMatch(lineText);
      var input = (firstMatch == null) ? lineText : firstMatch[1]!;

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
    var date = DateTime.parse(firstMath[1]!);
    var description = firstMath[2]!.trim();

    List<Posting> postings = [];
    PostingDto? postingDtoWithoutCommodity;
    for (int i = 1; i < txnText.length; i++) {
      var postingDto = parsePosting(txnText[i]);
      if (postingDto.commodity != null) {
        postings.add(Posting(date, postingDto.account, postingDto.commodity!,
            description: description));
      } else {
        postingDtoWithoutCommodity = postingDto;
      }
    }

    if (postingDtoWithoutCommodity != null) {
      var balancing = postings.fold(
        0.0,
        (previousValue, record) => previousValue + (record.commodity.amount),
      );
      var sample = postings.first.commodity;

      postings.add(Posting(date, postingDtoWithoutCommodity.account,
          Commodity(0.0 - balancing, sample.unit, sample.position),
          description: description));
    }
    return Transaction(
      date,
      postings,
      description: description,
    );
  }

  PostingDto parsePosting(String recordText) {
    var accountRegExp = RegExp(r'^\s+([\ \w:]+\w)\s{2,}(.*)');
    var firstMatch = accountRegExp.firstMatch(recordText)!;

    var accountText = firstMatch[1]!;
    var commodityText = firstMatch[2]!;

    return PostingDto(parseAccount(accountText),
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
      return Commodity(
          double.parse(amountText1), symbolMatch[1]!, UnitPosition.left);
    }

    /// 100.00 TWD
    var regExp = RegExp(r'(\-?[\d\.,]+)\s+(\w+)');
    var firstMatch = regExp.firstMatch(commodityText);

    var amountText2 = firstMatch![1]!.replaceAll(',', '');
    var unitText = firstMatch[2]!;
    return Commodity(double.parse(amountText2), unitText, UnitPosition.right);
  }
}
