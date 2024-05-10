part of 'write_contact_cubit.dart';

abstract class WriteContactState extends Equatable {
  final int? id;
  final String? name;
  final String? idNumber;
  final String? email;
  final String? phone;
  final String? address;
  final ContactType? type;
  final String? accountNumber;
  final String? accountHolderName;
  final String? bankName;
  final String? taxNumber;
  final String? details;
  final Failure? failure;
  final FormStatus formStatus;
  final AutovalidateMode? autovalidateMode;

  const WriteContactState({
    this.id,
    this.name = '',
    this.idNumber = '',
    this.email = '',
    this.phone = '',
    this.address = '',
    this.type,
    this.accountNumber = '',
    this.accountHolderName = '',
    this.bankName = '',
    this.taxNumber = '',
    this.details = '',
    this.failure,
    this.formStatus = FormStatus.initialized,
    this.autovalidateMode = AutovalidateMode.disabled,
  });

  WriteContactState copyWith({
    int? id,
    String? name,
    String? idNumber,
    String? email,
    String? phone,
    String? address,
    ContactType? type,
    String? accountNumber,
    String? accountHolderName,
    String? bankName,
    String? taxNumber,
    String? details,
    Failure? failure,
    FormStatus? formStatus,
    AutovalidateMode? autovalidateMode,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        idNumber,
        email,
        phone,
        address,
        type,
        accountNumber,
        accountHolderName,
        bankName,
        taxNumber,
        details,
        failure,
        formStatus,
        autovalidateMode,
      ];
}

final class WriteContactValidator extends WriteContactState {
  const WriteContactValidator({
    super.id,
    super.name = '',
    super.idNumber = '',
    super.email = '',
    super.phone = '',
    super.address = '',
    super.type,
    super.accountNumber = '',
    super.accountHolderName = '',
    super.bankName = '',
    super.taxNumber = '',
    super.details = '',
    super.failure,
    super.formStatus = FormStatus.initialized,
    super.autovalidateMode = AutovalidateMode.disabled,
  });

  @override
  WriteContactState copyWith({
    int? id,
    String? name,
    String? idNumber,
    String? email,
    String? phone,
    String? address,
    ContactType? type,
    String? accountNumber,
    String? accountHolderName,
    String? bankName,
    String? taxNumber,
    String? details,
    Failure? failure,
    FormStatus? formStatus,
    AutovalidateMode? autovalidateMode,
  }) {
    return WriteContactValidator(
      id: id ?? this.id,
      name: name ?? this.name,
      idNumber: idNumber ?? this.idNumber,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      type: type ?? this.type,
      accountNumber: accountNumber ?? this.accountNumber,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      bankName: bankName ?? this.bankName,
      taxNumber: taxNumber ?? this.taxNumber,
      details: details ?? this.details,
      failure: failure ?? this.failure,
      formStatus: formStatus ?? this.formStatus,
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
    );
  }
}
