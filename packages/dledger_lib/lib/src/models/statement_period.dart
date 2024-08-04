import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

enum PeriodType { daily, weekly, monthly, yearly }

class StatementPeriod extends Equatable {
  final DateTime _date;
  final PeriodType _periodType;

  DateTime get date {
    switch (_periodType) {
      case PeriodType.daily:
        return _date;
      case PeriodType.weekly:
        throw Exception('report by weekly is not supported yet');
      case PeriodType.monthly:
        return DateTime(_date.year, _date.month);
      case PeriodType.yearly:
        return DateTime(_date.year);
    }
  }

  PeriodType get type => _periodType;

  const StatementPeriod(this._date, this._periodType);

  @override
  List<Object?> get props => [date, type];

  @override
  String toString() {
    switch (_periodType) {
      case PeriodType.daily:
        return DateFormat.yMd().format(date);
      case PeriodType.weekly:
        throw Exception('report by weekly is not supported yet');
      case PeriodType.monthly:
        return DateFormat.yM().format(date);
      case PeriodType.yearly:
        return DateFormat.y().format(date);
    }
  }
}
