class Commodity {
  final double amount;
  final String unit;
  final UnitPosition position;
  final Commodity? cost;

  Commodity(this.amount, this.unit, this.position, {this.cost});

  @override
  String toString() {
    return position == UnitPosition.left
        ? 'Commodity( $unit$amount, "cost": $cost)'
        : 'Commodity( $amount $unit, "cost": $cost)';
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
}

enum UnitPosition { left, right }
