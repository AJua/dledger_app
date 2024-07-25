class Commodity {
  final double amount;
  final String unit;
  final Commodity? cost;

  Commodity(this.amount, this.unit, {this.cost});

  @override
  String toString() {
    return 'Commodity("amount": $amount, "unit": $unit, "cost": $cost)';
  }

  @override
  Commodity operator +(Commodity other) {
    // TODO: implement ==
    if (unit != other.unit) {
      throw Exception(
        'Commodity must be same unit, this: $this, other: $other',
      );
    }
    return Commodity(amount + other.amount, unit);
  }
}
