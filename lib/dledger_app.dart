import 'package:dledger_app/pages/income_statement_page.dart';
import 'package:flutter/material.dart';

/// The application that contains datagrid on it.
class DLedgerApp extends StatelessWidget {
  const DLedgerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: const Key('dledger-app'),
      title: 'dledger-app',
      theme: ThemeData(useMaterial3: false),
      home: const IncomeStatementPage(),
    );
  }
}
