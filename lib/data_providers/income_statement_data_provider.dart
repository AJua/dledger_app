import 'package:dledger_app/models/income_statement.dart';
import 'package:dledger_lib/models/commodity.dart';

class IncomeStatementDataProvider {
  IncomeStatement get() {
    return IncomeStatement({}, {
      'car': {
        '2024-07-24': Commodity(100, 'TWD'),
        '2024-07-25': Commodity(100, 'TWD'),
        '2024-07-26': Commodity(100, 'TWD'),
      },
      '  games': {
        '2024-07-24': Commodity(100000, 'TWD'),
        '2024-07-25': Commodity(100000, 'TWD'),
        '2024-07-26': Commodity(100000, 'TWD'),
      },
      '  foods': {
        '2024-07-24': Commodity(100000, 'TWD'),
        '2024-07-25': Commodity(100, 'TWD'),
        '2024-07-26': Commodity(100, 'TWD'),
      },
      'rent': {
        '2024-07-24': Commodity(100000, 'TWD'),
        '2024-07-25': Commodity(100000, 'TWD'),
        '2024-07-26': Commodity(100000, 'TWD'),
      },
      'e': {
        '2024-07-24': Commodity(100000, 'TWD'),
        '2024-07-25': Commodity(100000, 'TWD'),
        '2024-07-26': Commodity(100000, 'TWD'),
      },
      'a': {
        '2024-07-24': Commodity(100000, 'TWD'),
        '2024-07-25': Commodity(100000, 'TWD'),
        '2024-07-26': Commodity(100000, 'TWD'),
      },
      'c': {
        '2024-07-24': Commodity(100000, 'TWD'),
        '2024-07-25': Commodity(100000, 'TWD'),
        '2024-07-26': Commodity(100000, 'TWD'),
      },
    });
  }
}
