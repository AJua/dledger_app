import 'package:dledger_lib/dledger_lib.dart';
import 'package:equatable/equatable.dart';

class FinancialStats extends Equatable {
  final Map<Account, Statement> _all;
  final PeriodType _periodType;

  final Set<StatementPeriod> _distinctPeriods;
  final bool _isTree;

  Iterable<StatementPeriod> get distinctPeriods => _distinctPeriods;

  Map<Account, Statement> get all => _all;

  FinancialStats._(this._periodType, this._isTree)
      : _all = {},
        _distinctPeriods = {};

  factory FinancialStats.empty(PeriodType type, {bool isTree = false}) {
    return FinancialStats._(type, isTree);
  }

  @override
  List<Object?> get props => [all];

  void add(Posting posting) {
    if (_isTree) {
      for (var p in posting.tree) {
        _add(p);
      }
    } else {
      _add(posting);
    }
  }

  void _add(Posting posting) {
    var period = StatementPeriod(posting.date, _periodType);
    _distinctPeriods.add(period);
    if (_all.containsKey(posting.account)) {
      if (_all[posting.account]!.details.containsKey(period)) {
        var commodities = _all[posting.account]!.details[period];
        commodities!.add(posting.commodity);
      } else {
        var commodities = Commodities.empty()..add(posting.commodity);
        _all[posting.account]!.details[period] = commodities;
      }
    } else {
      var commodities = Commodities.empty()..add(posting.commodity);
      _all[posting.account] = Statement(posting.account, {period: commodities});
    }
  }

  void fillNullValueWithEmpty(Iterable<StatementPeriod> periods) {
    for (var p in periods) {
      for (var account in _all.keys) {
        if (!_all[account]!.details.containsKey(p)) {
          _all[account]!.details[p] = Commodities.empty();
        }
      }
    }
  }
}
