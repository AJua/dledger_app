import 'package:equatable/equatable.dart';

enum PeriodType { daily, weekly, monthly, yearly }

class Period extends Equatable {
  final DateTime _begin;
  final DateTime _end;
  final PeriodType _periodType;

  DateTime get begin => _begin;

  DateTime get end => _end;

  PeriodType get type => _periodType;

  const Period(this._begin, this._end, this._periodType);

  @override
  // TODO: implement props
  List<Object?> get props => [begin, end, type];
}
