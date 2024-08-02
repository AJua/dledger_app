import 'package:dledger_app/src/journal_editor/app_state.dart';
import 'package:flutter/material.dart';

import 'app_state_manager.dart';
import 'basic_text_field.dart';
import 'formatting_toolbar.dart';
import 'replacements.dart';
import 'text_editing_delta_history_view.dart';

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
    print(_replacementTextEditingController.value.text);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _replacementTextEditingController =
        AppStateManager.of(context).appState.replacementsController;
  }

  static Route<Object?> _aboutDialogBuilder(
      BuildContext context, Object? arguments) {
    const String aboutContent =
        'TextEditingDeltas are a new feature in the latest Flutter stable release that give the user'
        ' finer grain control over the changes that occur during text input. There are four types of'
        ' deltas: Insertion, Deletion, Replacement, and NonTextUpdate. To gain access to these TextEditingDeltas'
        ' you must implement DeltaTextInputClient, and set enableDeltaModel to true in the TextInputConfiguration.'
        ' Before Flutter only provided the TextInputClient, which does not provide a delta between the current'
        ' and previous text editing states. DeltaTextInputClient does provide these deltas, allowing the user to build'
        ' more powerful rich text editing applications such as this small example. This feature is supported on all platforms.';
    return DialogRoute<void>(
      context: context,
      builder: (context) => const AlertDialog(
        title: Center(child: Text('About')),
        content: Text(aboutContent),
      ),
    );
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).restorablePush(_aboutDialogBuilder);
            },
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: BasicTextField(
                    controller: _replacementTextEditingController,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                    focusNode: _focusNode,
                  ),
                ),
              ),
              const Expanded(
                child: TextEditingDeltaHistoryView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
