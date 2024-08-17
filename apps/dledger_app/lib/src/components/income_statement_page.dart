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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var journal = context.watch<Journal>();
    if (!journal.isLoaded) {
      return const Text('loading...');
    }
    var incomeStatement = journal.getIncomeStatement();
    var dataSource = IncomeStatementDataSource(incomeStatement);
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
