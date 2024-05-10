import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_type.dart';

class ContactModel extends Contact {
  const ContactModel({
    super.id,
    required super.name,
    required super.address,
    super.idNumber,
    required super.phone,
    required super.email,
    required super.type,
    super.accountNumber,
    super.accountHolderName,
    super.bankName,
    super.taxNumber,
    super.details,
  });

  factory ContactModel.fromEntity(Contact contact) => ContactModel(
        id: contact.id,
        name: contact.name,
        idNumber: contact.idNumber,
        address: contact.address,
        phone: contact.phone,
        email: contact.email,
        type: contact.type,
        accountNumber: contact.accountNumber,
        accountHolderName: contact.accountHolderName,
        bankName: contact.bankName,
        taxNumber: contact.taxNumber,
        details: contact.details,
      );

  factory ContactModel.fromMap(Map<String, dynamic> json) => ContactModel(
        id: json['id'],
        name: json['name'],
        idNumber: json['idNumber'],
        address: json['address'],
        phone: json['phone'],
        email: json['email'],
        type: ContactType.fromString(json["type"]),
        accountNumber: json['accountNumber'],
        accountHolderName: json['accountHolderName'],
        bankName: json['bankName'],
        taxNumber: json['taxNumber'],
        details: json['details'],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "idNumber": idNumber,
        "address": address,
        "phone": phone,
        "email": email,
        "type": type.toJSON(),
        "accountNumber": accountNumber,
        "accountHolderName": accountHolderName,
        "bankName": bankName,
        "taxNumber": taxNumber,
        "details": details,
      };
}
