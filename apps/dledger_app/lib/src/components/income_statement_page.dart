import 'package:dledger_app/src/data_providers/income_statement_data_provider.dart';
import 'package:dledger_app/src/models/income_statement_data_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// The home page of the application which hosts the datagrid.
class IncomeStatementView extends StatefulWidget {
  /// Creates the home page.
  const IncomeStatementView({super.key});

  @override
  State<IncomeStatementView> createState() => _IncomeStatementViewState();
}

class _IncomeStatementViewState extends State<IncomeStatementView> {
  late IncomeStatementDataSource dataSource;

  @override
  void initState() {
    super.initState();
    var statement = IncomeStatementDataProvider().get();
    dataSource = IncomeStatementDataSource(incomeStatement: statement);
  }

  @override
  Widget build(BuildContext context) {
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
