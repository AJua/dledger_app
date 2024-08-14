import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    ErrorHandler().handleError(details.exception, details.stack);
  };
  runApp(const DLedgerApp());
}

class ErrorHandler {
  void handleError(dynamic error, StackTrace? stacktrace) {
    if (kDebugMode) {
      print('Error caught: $error');
      print('Stacktrace: $stacktrace');
    }
  }
}
