import 'package:dledger_lib/extensions/postings_extension.dart';
import 'package:dledger_lib/extensions/summary_extension.dart';
import 'package:dledger_lib/models/commodity.dart';
import 'package:dledger_lib/utils/income_statement_reporter.dart';
import 'package:dledger_lib/utils/journal_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var journalText = '''
2024-07-12 高鐵票
    Liabilities:CreditCard:玉山Pi信用卡
    Expenses:Transportation:PublicService  700.00 TWD
  ''';
  test('integration', () {
    var journal = JournalParser().parseJournal(journalText);
    var statement = IncomeStatementReporter().getIncomeStatement(journal);
    expect(statement.incomes.summarize().expandAccount(1), equals({}));
    var actual = statement.expenses.summarize().expandAccount(1);
    expect(
        actual,
        equals({
          'Expenses': {
            '2024-07-12': const Commodity(700.0, 'TWD', UnitPosition.right)
          }
        }));
  });
}
