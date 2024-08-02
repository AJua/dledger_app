import 'dart:io';

import 'package:dledger_app/src/journal_editor/replacements.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                FilePicker.platform
                    .pickFiles(allowMultiple: false)
                    .then((result) {
                  if (result == null) return;
                  var file = File(result.files.first.path!);
                  var text = file.readAsStringSync();
                  controller.text = text;
                  //controller.applyReplacement(TextEditingInlineSpanReplacement(range, generator, expand))
                });
              },
              icon: const Icon(Icons.file_open)),
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
