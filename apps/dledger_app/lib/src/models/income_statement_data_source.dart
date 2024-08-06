import 'package:collection/collection.dart';
import 'package:dledger_lib/dledger_lib.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class IncomeStatementDataSource extends DataGridSource {
  IncomeStatementDataSource(Map<String, FinancialStats> statements) {
    _columns = [
      _gridColumn('account', ''),
      ...statements['income']!
          .all
          .entries
          .first
          .value
          .details
          .keys
          // sort period
          .sorted((key1, key2) => key1.date.compareTo(key2.date))
          .map((key) => _gridColumn(key.toString(), key.toString()))
    ];
    _rows = [
      ...getRows(statements, 'income'),
      ...getRows(statements, 'expenses'),
    ];
  }

  List<DataGridRow> getRows(
      Map<String, FinancialStats> statements, String category) {
    var rows = statements[category]!
        .all
        .values
        // sort account
        .sorted((s2, s1) {
          for (var i = 2;
              i <= s1.account.hierarchy.length &&
                  i <= s2.account.hierarchy.length;
              i++) {
            var result = statements[category]!
                .all[Account(s1.account.hierarchy.sublist(0, i))]!
                .compareTo(statements[category]!
                    .all[Account(s2.account.hierarchy.sublist(0, i))]!);
            if (result == 0) {
              continue;
            }
            return result;
          }
          var result = s1.account.hierarchy.length
              .compareTo(s2.account.hierarchy.length);
          if (result == 0) {
            return s1.compareTo(s2);
          }
          return -result;
        })
        .map((accountEntry) => DataGridRow(
              cells: [
                DataGridCell<String>(
                    columnName: 'account',
                    value: accountEntry.account.displayName(isTree: true)),
                ...accountEntry.details.entries
                    // sort period
                    .sorted((entry1, entry2) =>
                        entry1.key.date.compareTo(entry2.key.date))
                    .map((commodityEntry) => _dataGridCell(commodityEntry))
              ],
            ))
        .toList();
    return rows;
  }

  DataGridCell<String> _dataGridCell(
      MapEntry<StatementPeriod, Commodities> commodityEntry) {
    var value =
        commodityEntry.value.all['TWD']?.amountFormat(isDisplayUnit: false) ??
            '0';
    return DataGridCell<String>(
      columnName: commodityEntry.key.toString(),
      value: value,
    );
  }

  GridColumn _gridColumn(String name, String value) {
    return GridColumn(
        columnName: name,
        width: name == 'account' ? 188 : 100.0,
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
        alignment: e.columnName == 'account'
            ? Alignment.centerLeft
            : Alignment.centerRight,
        //padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
        child: Text(
          '  ${e.value.toString()}  ',
          style: GoogleFonts.robotoMono(
              fontWeight: (row.getCells().first.value as String).startsWith(' ')
                  ? FontWeight.normal
                  : FontWeight.bold),
          softWrap: false,
        ),
      );
    }).toList());
  }
}
