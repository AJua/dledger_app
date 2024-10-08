import 'package:dledger_lib/dledger_lib.dart';
import 'package:equatable/equatable.dart';

class Commodities extends Equatable {
  final Map<String, Commodity> _all;

  Map<String, Commodity> get all => _all;

  Commodities._() : _all = {};

  factory Commodities.empty() {
    return Commodities._();
  }

  @override
  List<Object?> get props => [all];

  void add(Commodity commodity) {
    var unit = commodity.unit;
    if (_all.containsKey(unit)) {
      _all[unit] = _all[unit]! + commodity;
    } else {
      _all[unit] = commodity;
    }
  }

  Commodities operator +(Commodities other) {
    var result = Commodities.empty();
    for (var c in all.values) {
      result.add(c);
    }
    for (var c in other.all.values) {
      result.add(c);
    }
    return result;
  }

  double get totalAmount => _all.values.fold(0.0, (v, commodity) => v + commodity.amount);
}
