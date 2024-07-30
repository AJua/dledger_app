import 'package:dledger_app/pages/income_statement_page.dart';
import 'package:flutter/cupertino.dart';

/// The application that contains datagrid on it.
class DLedgerApp extends StatelessWidget {
  const DLedgerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      key: Key('dledger-app'),
      title: 'dledger-app',
      home: IncomeStatementPage(),
    );
  }
}
