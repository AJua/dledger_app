import 'package:dledger_lib/dledger_lib.dart';
import 'package:equatable/equatable.dart';

class FinancialStats extends Equatable {
  final Map<Account, Map<StatementPeriod, Commodities>> _all;
  final PeriodType _periodType;

  final Set<StatementPeriod> _periods;

  Iterable<StatementPeriod> get periods => _periods;

  Map<Account, Map<StatementPeriod, Commodities>> get all => _all;

  FinancialStats._(this._periodType)
      : _all = {},
        _periods = {};

  factory FinancialStats.empty(PeriodType type) {
    return FinancialStats._(type);
  }

  @override
  List<Object?> get props => [all];

  void add(Posting posting) {
    var period = StatementPeriod(posting.date, _periodType);
    _periods.add(period);
    if (_all.containsKey(posting.account)) {
      if (_all[posting.account]!.containsKey(period)) {
        var commodities = _all[posting.account]![period];
        commodities!.add(posting.commodity);
      } else {
        var commodities = Commodities.empty()..add(posting.commodity);
        _all[posting.account]![period] = commodities;
      }
    } else {
      var commodities = Commodities.empty()..add(posting.commodity);
      _all[posting.account] = {period: commodities};
    }
    for (var p in _periods) {
      for (var account in _all.keys) {
        if (!_all[account]!.containsKey(p)) {
          _all[account]![p] = Commodities.empty();
        }
      }
    }
  }
}
