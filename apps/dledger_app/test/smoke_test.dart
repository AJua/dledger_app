import 'package:dledger_app/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  const testMockStorage = './test/fixtures/core';
  const channel = MethodChannel(
    'plugins.flutter.io/path_provider',
  );
  testWidgets('smoke test, verify app can run', (WidgetTester tester) async {
    // mock the getApplicationDocumentsDirectory function in [LedgerFile]
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(channel,
        (MethodCall methodCall) async {
      return testMockStorage;
    });

    runApp(const DLedgerApp());
  });
}
