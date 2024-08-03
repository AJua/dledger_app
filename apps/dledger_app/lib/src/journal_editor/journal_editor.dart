import 'package:dledger_app/src/journal_editor/app_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app_state_manager.dart';
import 'basic_text_field.dart';
import 'formatting_toolbar.dart';
import 'replacements.dart';

class JournalEditor extends StatelessWidget {
  const JournalEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppStateWidget(child: MyHomePage(title: 'Simplistic Editor'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ReplacementTextEditingController _replacementTextEditingController;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _replacementTextEditingController = ReplacementTextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (kDebugMode) {
      print(_replacementTextEditingController.value.text);
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _replacementTextEditingController = AppStateManager.of(context).appState.replacementsController;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Center(
        child: Column(
          children: [
            FormattingToolbar(controller: _replacementTextEditingController),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: BasicTextField(
                  controller: _replacementTextEditingController,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: colorScheme.primary,
                  ),
                  focusNode: _focusNode,
                ),
              ),
            ),
            //const Expanded(
            //  child: TextEditingDeltaHistoryView(),
            //),
          ],
        ),
      ),
    );
  }
}
