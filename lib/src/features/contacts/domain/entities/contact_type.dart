import '../../../../core/exceptions/invalid_argument_exception.dart';

enum ContactType {
  client('Client'),
  //contractor('Contractor'),
  supplier('Supplier');

  final String name;
  const ContactType(this.name);

  @override
  String toString() => name;

  String toJSON() => name.toUpperCase().replaceAll(' ', '_');

  static ContactType fromString(String str) {
    switch (str.toLowerCase()) {
      case "client":
        return ContactType.client;
      case "contractor":
      case "supplier":
        return ContactType.supplier;
      default:
        return throw InvalidArgumentException(str);
    }
  }
}
