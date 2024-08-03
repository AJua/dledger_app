import 'dart:io';

class LedgerFile {
  File? _localFile;
  static const String sampleFile = r'''
2023-01-01 opening balances            ; <- First transaction sets starting balances.
    assets:bank:checking        $1000  ; <- Account names can be anything.
    assets:bank:savings         $2000  ; <- Colons indicate subaccounts.
    assets:cash                  $100  ; <- 2+ spaces are required before the amount.
    liabilities:credit card      $-50  ; <- A debt; these are negative.
    equity:opening/closing     $-3050  ; <- Starting balances come from equity.
                                       ;    Equity is also usually negative.
                                       ;    (Reports can show as positive when needed.)

2023-02-01 GOODWORKS CORP              ; <- Date order is recommended but optional.
    assets:bank:checking       $1000
    income:salary              $-1000  ; Income amounts are negative here
                                       ; This might be counter-intuition at first
                                       ; Since there is increase in assets:bank:checking
                                       ; You may think it as an negative expenses

2023-02-15 market
    expenses:food             $50
    assets:cash                        ; <- $-50 is inferred here. 
''';

  LedgerFile();

  String read() {
    return _localFile?.readAsStringSync() ?? sampleFile;
  }
}
