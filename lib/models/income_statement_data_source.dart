import 'package:dledger_lib/models/commodity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'income_statement.dart';

class IncomeStatementDataSource extends DataGridSource {
  IncomeStatementDataSource({required IncomeStatement incomeStatement}) {
    _columns = [
      _gridColumn('account'),
      ...incomeStatement.expenses.entries.first.value.keys
          .map((key) => _gridColumn(key))
    ];

    _rows = incomeStatement.expenses.entries
        .map((accountEntry) => DataGridRow(
              cells: [
                DataGridCell<String>(
                    columnName: 'account', value: accountEntry.key),
                ...accountEntry.value.entries
                    .map((commodityEntry) => _dataGridCell(commodityEntry))
              ],
            ))
        .toList();
  }

  DataGridCell<String> _dataGridCell(
      MapEntry<String, Commodity> commodityEntry) {
    var value = '${commodityEntry.value.amount} ${commodityEntry.value.unit}';
    return DataGridCell<String>(
      columnName: commodityEntry.key,
      value: value,
    );
  }

  GridColumn _gridColumn(String name) {
    return GridColumn(
        columnName: name,
        label: Container(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            alignment: Alignment.center,
            child: Text(
              name,
              style: GoogleFonts.robotoMono(),
              overflow: TextOverflow.ellipsis,
            )));
  }

  late List<GridColumn> _columns;

  List<GridColumn> get columns => _columns;
  late List<DataGridRow> _rows;

  @override
  List<DataGridRow> get rows => _rows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: e.columnName == 'account'
            ? Alignment.centerLeft
            : Alignment.centerRight,
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Text(
          e.value.toString(),
          style: GoogleFonts.robotoMono(),
        ),
      );
    }).toList());
  }
}
