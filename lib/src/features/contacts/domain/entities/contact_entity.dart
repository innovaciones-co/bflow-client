import 'package:bflow_client/src/features/contacts/domain/entities/contact_type.dart';
import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final int? id;
  final String name;
  final String? idNumber;
  final String address;
  final String phone;
  final String email;
  final ContactType type;
  final String? accountNumber;
  final String? accountHolderName;
  final String? bankName;
  final String? taxNumber;
  final String? details;

  const Contact({
    this.id,
    required this.name,
    this.idNumber,
    required this.address,
    required this.phone,
    required this.email,
    required this.type,
    this.accountNumber,
    this.accountHolderName,
    this.bankName,
    this.taxNumber,
    this.details,
  });

  @override
  List<Object> get props => [
        id ?? '',
        name,
        idNumber ?? '',
        address,
        phone,
        email,
        type,
        accountNumber ?? '',
        accountHolderName ?? '',
        bankName ?? '',
        taxNumber ?? '',
        details ?? '',
      ];

  @override
  bool? get stringify => true;
}
