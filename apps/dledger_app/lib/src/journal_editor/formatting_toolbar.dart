import 'dart:io';

import 'package:dledger_app/src/journal_editor/replacements.dart';
import 'package:dledger_app/src/utilities/ledger_file.dart';
import 'package:dledger_lib/dledger_lib.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global_variables.dart';
import 'app_state_manager.dart';

/// The toggle buttons that can be selected.
enum ToggleButtonsState {
  bold,
  italic,
  underline,
}

class FormattingToolbar extends StatelessWidget {
  final ReplacementTextEditingController controller;

  const FormattingToolbar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final AppStateManager manager = AppStateManager.of(context);
    final Journal journal = context.read<Journal>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () async {
              var result = await FilePicker.platform.pickFiles(allowMultiple: false);
              if (result == null) return;
              var file = File(result.files.first.path!);
              var text = file.readAsStringSync();
              journal.reload(JournalParser().parseJournal(text).transactions);
              controller.text = text;
            },
            icon: const Icon(Icons.file_open),
          ),
          IconButton(
            onPressed: () async {
              getIt<LedgerFile>().save(controller.text);
              //journal.reload(JournalParser().parseJournal(text).transactions);
            },
            icon: const Icon(Icons.save),
          ),
          //ToggleButtons(
          //  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          //  isSelected: [
          //    manager.appState.toggleButtonsState
          //        .contains(ToggleButtonsState.bold),
          //    manager.appState.toggleButtonsState
          //        .contains(ToggleButtonsState.italic),
          //    manager.appState.toggleButtonsState
          //        .contains(ToggleButtonsState.underline),
          //  ],
          //  onPressed: (index) => AppStateWidget.of(context)
          //      .updateToggleButtonsStateOnButtonPressed(index),
          //  children: const [
          //    Icon(Icons.format_bold),
          //    Icon(Icons.format_italic),
          //    Icon(Icons.format_underline),
          //  ],
          //),
        ],
      ),
    );
  }
}
