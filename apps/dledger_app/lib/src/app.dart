import 'package:dledger_app/src/global_variables.dart';
import 'package:dledger_lib/dledger_lib.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'enums/constants.dart';
import 'home.dart';
import 'utilities/ledger_file.dart';

class DLedgerApp extends StatefulWidget {
  const DLedgerApp({super.key});

  @override
  State<DLedgerApp> createState() => _DLedgerAppState();
}

class _DLedgerAppState extends State<DLedgerApp> {
  @override
  void initState() {
    super.initState();
    getIt.registerSingleton<LedgerFile>(LedgerFile());
  }

  bool useMaterial3 = true;
  ThemeMode themeMode = ThemeMode.system;
  ColorSeed colorSelected = ColorSeed.baseColor;
  ColorScheme? imageColorScheme = const ColorScheme.light();
  ColorSelectionMethod colorSelectionMethod = ColorSelectionMethod.colorSeed;

  bool get useLightMode => switch (themeMode) {
        ThemeMode.system =>
          View.of(context).platformDispatcher.platformBrightness ==
              Brightness.light,
        ThemeMode.light => true,
        ThemeMode.dark => false
      };

  void handleBrightnessChange(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void handleColorSelect(int value) {
    setState(() {
      colorSelectionMethod = ColorSelectionMethod.colorSeed;
      colorSelected = ColorSeed.values[value];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'dledger app',
      themeMode: themeMode,
      theme: ThemeData(
        colorSchemeSeed: colorSelectionMethod == ColorSelectionMethod.colorSeed
            ? colorSelected.color
            : null,
        colorScheme: colorSelectionMethod == ColorSelectionMethod.image
            ? imageColorScheme
            : null,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: colorSelectionMethod == ColorSelectionMethod.colorSeed
            ? colorSelected.color
            : imageColorScheme!.primary,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: ChangeNotifierProvider<Journal>(
        create: (BuildContext context) {
          var journal = Journal.init();
          getIt<LedgerFile>().read().then((journalText) async {
            journal
                .reload(JournalParser().parseJournal(journalText).transactions);
          });
          return journal;
        },
        child: Home(
          useLightMode: useLightMode,
          colorSelected: colorSelected,
          handleBrightnessChange: handleBrightnessChange,
          handleColorSelect: handleColorSelect,
          colorSelectionMethod: colorSelectionMethod,
        ),
      ),
    );
  }
}
