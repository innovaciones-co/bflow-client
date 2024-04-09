enum Unit {
  feet("Feet"),
  meters("Meters"),
  inches("Inches"),
  milimeters("Milimeters"),
  squareFeet("Square Feet"),
  squareMeters("Square Meters"),
  acres("Acres"),
  hectares("Hectares"),
  cubicFeet("Cubic Feet"),
  cubicMeters("Cubic Meters"),
  gallons("Gallons"),
  liters("Liters"),
  pounds("Pounds"),
  kilograms("Kilograms"),
  tons("Tons"),
  each("Each"),
  pieces("Pieces"),
  sets("Sets"),
  hours("Hours"),
  days("Days"),
  weeks("Weeks"),
  months("Months");

  final String name;
  const Unit(this.name);

  String get abbreviation {
    switch (this) {
      case Unit.feet:
        return 'ft';
      case Unit.meters:
        return 'm';
      case Unit.inches:
        return 'in';
      case Unit.milimeters:
        return 'mm';
      case Unit.squareFeet:
        return 'sq ft';
      case Unit.squareMeters:
        return 'sq m';
      case Unit.acres:
        return 'ac';
      case Unit.hectares:
        return 'ha';
      case Unit.cubicFeet:
        return 'cu ft';
      case Unit.cubicMeters:
        return 'cu m';
      case Unit.gallons:
        return 'gal';
      case Unit.liters:
        return 'L';
      case Unit.pounds:
        return 'lb';
      case Unit.kilograms:
        return 'kg';
      case Unit.tons:
        return 't';
      case Unit.each:
        return 'each';
      case Unit.pieces:
        return 'pcs';
      case Unit.sets:
        return 'sets';
      case Unit.hours:
        return 'hrs';
      case Unit.days:
        return 'days';
      case Unit.weeks:
        return 'wks';
      case Unit.months:
        return 'months';
      default:
        throw Exception('Invalid unit');
    }
  }

  factory Unit.fromString(String value) {
    switch (value.toLowerCase()) {
      case 'feet':
        return Unit.feet;
      case 'meters':
        return Unit.meters;
      case 'inches':
        return Unit.inches;
      case 'milimeters':
        return Unit.milimeters;
      case 'square_feet':
        return Unit.squareFeet;
      case 'square_meters':
        return Unit.squareMeters;
      case 'acres':
        return Unit.acres;
      case 'hectares':
        return Unit.hectares;
      case 'cubic_feet':
        return Unit.cubicFeet;
      case 'cubic_meters':
        return Unit.cubicMeters;
      case 'gallons':
        return Unit.gallons;
      case 'liters':
        return Unit.liters;
      case 'pounds':
        return Unit.pounds;
      case 'kilograms':
        return Unit.kilograms;
      case 'tons':
        return Unit.tons;
      case 'each':
        return Unit.each;
      case 'pieces':
        return Unit.pieces;
      case 'sets':
        return Unit.sets;
      case 'hours':
        return Unit.hours;
      case 'days':
        return Unit.days;
      case 'weeks':
        return Unit.weeks;
      case 'months':
        return Unit.months;
      default:
        throw Exception('Invalid abbreviation');
    }
  }

  @override
  String toString() => abbreviation;

  String toJSON() => name.toUpperCase().replaceAll(' ', '_');
}
