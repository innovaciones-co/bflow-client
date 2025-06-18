enum Unit {
  acres('Acres', 'ac'),
  amount('Amount', 'amount'),
  cubicFeet('Cubic Feet', 'cu ft'),
  cubicMeters('Cubic Meters', 'cu m'),
  days('Days', 'days'),
  each('Each', 'each'),
  feet('Feet', 'ft'),
  gallons('Gallons', 'gal'),
  hectares('Hectares', 'ha'),
  hours('Hours', 'hrs'),
  inches('Inches', 'in'),
  kilograms('Kilograms', 'kg'),
  liters('Liters', 'L'),
  meters('Meters', 'm'),
  millimeters('Millimeters', 'mm'),
  months('Months', 'months'),
  pieces('Pieces', 'pcs'),
  pounds('Pounds', 'lb'),
  sets('Sets', 'sets'),
  sheets('Sheets', 'sheets'),
  squareFeet('Square Feet', 'sq ft'),
  squareMeters('Square Meters', 'sq m'),
  text('Text', 'text'),
  tons('Tons', 't'),
  unit('Unit', 'u'),
  weeks('Weeks', 'wks');

  final String name;
  final String abbreviation;

  const Unit(this.name, this.abbreviation);

  static final Map<String, Unit> _lookup = {
    for (var unit in Unit.values)
      unit.name.toLowerCase().replaceAll(' ', '_'): unit
  };

  factory Unit.fromString(String value) {
    final normalized = value.toLowerCase().replaceAll(' ', '_');
    return _lookup[normalized] ?? (throw Exception('Invalid unit: $value'));
  }

  @override
  String toString() => abbreviation;

  String toJSON() => name.toUpperCase().replaceAll(' ', '_');
}
