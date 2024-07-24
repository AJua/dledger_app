import 'package:flutter/material.dart';

import 'pages/my_home_page.dart';

/// The application that contains datagrid on it.
class DLedgerApp extends StatelessWidget {
  const DLedgerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syncfusion DataGrid Demo',
      theme: ThemeData(useMaterial3: false),
      home: MyHomePage(),
    );
  }
}
