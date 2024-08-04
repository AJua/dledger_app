import 'package:dledger_lib/dledger_lib.dart';
import 'package:dledger_lib/src/aggregates/commodities.dart';
import 'package:equatable/equatable.dart';

class Statements extends Equatable {
  final Map<Account, Map<StatementPeriod, Commodities>> _all;
  final PeriodType type;

  final Set<StatementPeriod> _periods;

  Iterable<StatementPeriod> get periods => _periods;

  Map<Account, Map<StatementPeriod, Commodities>> get all => _all;

  Statements._(this.type)
      : _all = {},
        _periods = {};

  factory Statements.empty(PeriodType type) {
    return Statements._(type);
  }

  @override
  List<Object?> get props => [all];

  void add(Posting posting) {
    if (_all.containsKey(posting.account)) {
      //var period = posting.date.
    } else {
      var commodities = Commodities.empty()..add(posting.commodity);
      _all[posting.account] = {
        StatementPeriod(posting.date, type): commodities,
      };
    }
  }
}
