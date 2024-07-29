import 'package:equatable/equatable.dart';

class Commodity extends Equatable {
  final double amount;
  final String unit;
  final UnitPosition position;
  final Commodity? cost;

  const Commodity(this.amount, this.unit, this.position, {this.cost});

  String amountFormat() {
    return position == UnitPosition.left ? '$unit$amount' : '$amount $unit';
  }

  Commodity operator +(Commodity other) {
    // TODO: implement ==
    if (unit != other.unit || position != other.position) {
      throw Exception(
        'Commodity must be same unit and position, this: $this, other: $other',
      );
    }
    return Commodity(amount + other.amount, unit, position);
  }

  @override
  List<Object?> get props => [amount, unit, position];

  factory Commodity.zero() {
    return const Commodity(0, 'unit', UnitPosition.none);
  }
}

enum UnitPosition { left, right, none }
