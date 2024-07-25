import 'package:dledger_app/data_providers/income_statement_data_provider.dart';
import 'package:dledger_app/models/income_statement_data_source.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// The home page of the application which hosts the datagrid.
class IncomeStatementPage extends StatefulWidget {
  /// Creates the home page.
  const IncomeStatementPage({super.key});

  @override
  State<IncomeStatementPage> createState() => _IncomeStatementPageState();
}

class _IncomeStatementPageState extends State<IncomeStatementPage> {
  late IncomeStatementDataSource dataSource;

  @override
  void initState() {
    super.initState();
    var statement = IncomeStatementDataProvider().get();
    dataSource = IncomeStatementDataSource(incomeStatement: statement);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter DataGrid'),
      ),
      body: SafeArea(
        child: SfDataGrid(
          source: dataSource,
          headerRowHeight: 36,
          rowHeight: 36,
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          gridLinesVisibility: GridLinesVisibility.none,
          frozenRowsCount: 0,
          frozenColumnsCount: 1,
          columns: dataSource.columns,
          tableSummaryRows: [
            GridTableSummaryRow(
                showSummaryInRow: true,
                title: 'Total Salary: {Sum} for 20 employees',
                columns: [
                  const GridSummaryColumn(
                      name: 'Sum',
                      columnName: 'salary',
                      summaryType: GridSummaryType.sum)
                ],
                position: GridTableSummaryRowPosition.bottom)
          ],
        ),
      ),
    );
  }
}
