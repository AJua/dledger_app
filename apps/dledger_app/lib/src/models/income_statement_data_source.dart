import 'package:collection/collection.dart';
import 'package:dledger_lib/dledger_lib.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class IncomeStatementDataSource extends DataGridSource {
  IncomeStatementDataSource(Map<String, Statements> statements) {
    _columns = [
      _gridColumn('account', ''),
      ...statements['expenses']!
          .all
          .entries
          .first
          .value
          .keys
          // sort period
          .sorted((key1, key2) => key1.date.compareTo(key2.date))
          .map((key) => _gridColumn(key.toString(), key.toString()))
    ];

    _rows = statements['expenses']!
        .all
        .entries
        // sort account
        .sorted((e1, e2) => e2.value.values
            .fold(Commodities.empty(), (c1, c2) => c1 + c2)
            .all['TWD']!
            .amount
            .compareTo(
                e1.value.values.fold(Commodities.empty(), (c1, c2) => c1 + c2).all['TWD']!.amount))
        .map((accountEntry) => DataGridRow(
              cells: [
                DataGridCell<String>(
                    columnName: 'account', value: accountEntry.key.hierarchy.sublist(1).join(':')),
                ...accountEntry.value.entries
                    // sort period
                    .sorted((entry1, entry2) => entry1.key.date.compareTo(entry2.key.date))
                    .map((commodityEntry) => _dataGridCell(commodityEntry))
              ],
            ))
        .toList();
  }

  DataGridCell<String> _dataGridCell(MapEntry<StatementPeriod, Commodities> commodityEntry) {
    var value = commodityEntry.value.all['TWD']?.amountFormat(isDisplayUnit: false) ?? '0';
    return DataGridCell<String>(
      columnName: commodityEntry.key.toString(),
      value: value,
    );
  }

  GridColumn _gridColumn(String name, String value) {
    return GridColumn(
        columnName: name,
        width: name == 'account' ? 240 : 100.0,
        label: Container(
            //padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            alignment: Alignment.center,
            child: Text(
              value,
              softWrap: false,
              style: GoogleFonts.robotoMono(),
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
        alignment: e.columnName == 'account' ? Alignment.centerLeft : Alignment.centerRight,
        //padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
        child: Text(
          '  ${e.value.toString()}  ',
          style: GoogleFonts.robotoMono(),
          softWrap: false,
        ),
      );
    }).toList());
  }
}
