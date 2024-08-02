// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../journal_editor/journal_editor.dart';

class TypographyScreen extends StatefulWidget {
  const TypographyScreen({super.key});

  @override
  State<TypographyScreen> createState() => _TypographyScreenState();
}

class _TypographyScreenState extends State<TypographyScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // opens storage to pick files and the picked file or files
    // are assigned into result and if no file is chosen result is null.
    // you can also toggle "allowMultiple" true or false depending on your need
  }

  String content = '';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return const Expanded(
      child: JournalEditor(),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ToggleButtons(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              isSelected: const [
                false,
                false,
                false,
              ],
              onPressed: (index) {
                FilePicker.platform
                    .pickFiles(allowMultiple: false)
                    .then((result) {
                  if (result == null) return;
                  var file = File(result.files.first.path!);
                  var text = file.readAsStringSync();
                  setState(() {
                    content = text;
                  });
                });
              },
              children: const [
                Icon(Icons.format_bold),
                Icon(Icons.format_italic),
                Icon(Icons.format_underline),
              ],
            ),
          ],
        ),
        //SingleChildScrollView(
        //    child:
        //        TextStyleExample(name: content, style: textTheme.bodyLarge!)),
      ],
    );
    return Expanded(
      child: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToggleButtons(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                isSelected: const [
                  false,
                  false,
                  false,
                ],
                onPressed: (index) {
                  FilePicker.platform
                      .pickFiles(allowMultiple: false)
                      .then((result) {
                    if (result == null) return;
                    var file = File(result.files.first.path!);
                    var text = file.readAsStringSync();
                    setState(() {
                      content = text;
                    });
                  });
                },
                children: const [
                  Icon(Icons.format_bold),
                  Icon(Icons.format_italic),
                  Icon(Icons.format_underline),
                ],
              ),
            ],
          ),
          const SizedBox(height: 3),
          //TextStyleExample(
          //    name: 'Display Large', style: textTheme.displayLarge!),
          //TextStyleExample(
          //    name: 'Display Medium', style: textTheme.displayMedium!),
          //TextStyleExample(
          //    name: 'Display Small', style: textTheme.displaySmall!),
          //TextStyleExample(
          //    name: 'Headline Large', style: textTheme.headlineLarge!),
          //TextStyleExample(
          //    name: 'Headline Medium', style: textTheme.headlineMedium!),
          //TextStyleExample(
          //    name: 'Headline Small', style: textTheme.headlineSmall!),
          //TextStyleExample(name: 'Title Large', style: textTheme.titleLarge!),
          //TextStyleExample(name: 'Title Medium', style: textTheme.titleMedium!),
          //TextStyleExample(name: 'Title Small', style: textTheme.titleSmall!),
          //TextStyleExample(name: 'Label Large', style: textTheme.labelLarge!),
          //TextStyleExample(name: 'Label Medium', style: textTheme.labelMedium!),
          //TextStyleExample(name: 'Label Small', style: textTheme.labelSmall!),
          //TextStyleExample(name: 'Body Large', style: textTheme.bodyLarge!),
          //TextStyleExample(name: 'Body Medium', style: textTheme.bodyMedium!),
          //TextStyleExample(name: 'Body Small', style: textTheme.bodySmall!),
          TextStyleExample(name: content, style: textTheme.bodyLarge!),
        ],
      ),
    );
  }
}

class TextStyleExample extends StatelessWidget {
  const TextStyleExample({
    super.key,
    required this.name,
    required this.style,
  });

  final String name;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(name, style: style),
    );
  }
}
