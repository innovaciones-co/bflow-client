import 'package:bflow_client/src/features/contacts/domain/entities/contact_type.dart';
import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final int? id;
  final String name;
  final String? address;
  final String email;
  final ContactType type;

  const Contact({
    this.id,
    required this.name,
    this.address,
    required this.email,
    required this.type,
  });

  @override
  List<Object> get props => [id ?? '', name, address ?? '', email, type];

  @override
  bool? get stringify => true;
}
