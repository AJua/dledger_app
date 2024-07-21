class Commodity {
  final double amount;
  final String unit;
  final Commodity? cost;

  Commodity(this.amount, this.unit, {this.cost});

  @override
  String toString() {
    return 'Commodity("amount": $amount, "unit": $unit, "cost": $cost)';
  }
}
