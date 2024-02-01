import 'package:bflow_client/src/features/jobs/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/contact_type.dart';

class ContactModel extends Contact {
  ContactModel({
    required super.id,
    required super.name,
    super.address,
    required super.email,
    required super.type,
  });

  factory ContactModel.fromMap(Map<String, dynamic> json) => ContactModel(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        email: json["email"],
        type: ContactType.fromString(json["type"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "address": address,
        "email": email,
        "type": type.toJSON(),
      };
}
