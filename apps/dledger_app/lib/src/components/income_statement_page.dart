import 'package:collection/collection.dart';
import 'package:dledger_app/src/models/income_statement_data_source.dart';
import 'package:dledger_lib/dledger_lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// The home page of the application which hosts the datagrid.
class IncomeStatementDisplay extends StatefulWidget {
  /// Creates the home page.
  const IncomeStatementDisplay({super.key});

  @override
  State<IncomeStatementDisplay> createState() => _IncomeStatementDisplayState();
}

class _IncomeStatementDisplayState extends State<IncomeStatementDisplay> {
  //late IncomeStatementDataSource dataSource;

  @override
  void initState() {
    super.initState();
    //var statement = IncomeStatementDataProvider().get();
    //dataSource = IncomeStatementDataSource(incomeStatement: statement);
  }

  @override
  Widget build(BuildContext context) {
    var journal = context.watch<Journal>();
    if (!journal.isLoaded) {
      return const Text('loading...');
    }
    var allPostings = journal.transactions.fold<Iterable<Posting>>(
      [],
      (postings, transaction) => [...transaction.postings, ...postings],
    );
    var result = allPostings.groupFoldBy<String, FinancialStats>(
        (posting) => posting.account.mainCategory, (previous, posting) {
      if (previous == null) {
        return FinancialStats.empty(PeriodType.monthly, isTree: true)
          ..add(posting);
      }
      return previous..add(posting);
    });
    var periods = result.entries.fold<Set<StatementPeriod>>(
        {}, (ps, s) => ps..addAll(s.value.distinctPeriods));
    for (var entry in result.entries) {
      entry.value.fillNullValueWithEmpty(periods);
    }

    var dataSource = IncomeStatementDataSource(result);
    return SfDataGrid(
      source: dataSource,
      headerRowHeight: 32,
      rowHeight: 32,
      columnWidthMode: ColumnWidthMode.none,
      gridLinesVisibility: GridLinesVisibility.none,
      frozenRowsCount: 0,
      frozenColumnsCount: 1,
      columns: dataSource.columns,
    );
  }
}
