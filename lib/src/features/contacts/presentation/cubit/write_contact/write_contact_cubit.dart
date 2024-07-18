import 'package:bflow_client/src/core/domain/entities/form_status.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_type.dart';
import 'package:bflow_client/src/features/contacts/domain/usecases/create_contact_usecase.dart';
import 'package:bflow_client/src/features/contacts/domain/usecases/update_contact_usecase.dart';
import 'package:bflow_client/src/features/contacts/presentation/cubit/contacts_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'write_contact_state.dart';

class WriteContactCubit extends Cubit<WriteContactState> {
  final CreateContactUseCase createContactUseCase;
  final UpdateContactUseCase updateContactUseCase;
  final ContactsCubit contactsCubit;

  WriteContactCubit({
    required this.contactsCubit,
    required this.createContactUseCase,
    required this.updateContactUseCase,
  }) : super(const WriteContactValidator());

  void initForm({
    final int? id,
    final String name = '',
    final String idNumber = '',
    final String email = '',
    final String phone = '',
    final String address = '',
    final ContactType? type,
    final String accountNumber = '',
    final String accountHolderName = '',
    final String bankName = '',
    final String taxNumber = '',
    final String details = '',
  }) {
    emit(state.copyWith(
      id: id,
      name: name,
      idNumber: idNumber,
      email: email,
      phone: phone,
      address: address,
      type: type,
      accountNumber: accountNumber,
      accountHolderName: accountHolderName,
      bankName: bankName,
      taxNumber: taxNumber,
      details: details,
    ));
  }

  void initFormFromContact(Contact? contact) {
    if (contact == null) {
      return;
    }
    initForm(
      id: contact.id,
      name: contact.name,
      idNumber: contact.idNumber ?? '',
      email: contact.email,
      phone: contact.phone,
      address: contact.address,
      type: contact.type,
      accountNumber: contact.accountNumber ?? '',
      accountHolderName: contact.accountHolderName ?? '',
      bankName: contact.bankName ?? '',
      taxNumber: contact.taxNumber ?? '',
      details: contact.details ?? '',
    );
  }

  Future<void> createContact() async {
    emit(state.copyWith(formStatus: FormStatus.inProgress));

    Contact contact = Contact(
      name: state.name!,
      idNumber: state.idNumber,
      email: state.email!,
      phone: state.phone!,
      address: state.address!,
      type: state.type!,
      accountNumber: state.accountNumber,
      accountHolderName: state.accountHolderName,
      bankName: state.bankName,
      taxNumber: state.taxNumber,
      details: state.details,
    );

    final failureOrContact = await createContactUseCase.execute(
      CreateContactParams(contact: contact),
    );

    failureOrContact.fold(
      (failure) =>
          emit(state.copyWith(failure: failure, formStatus: FormStatus.failed)),
      (contact) {
        emit(state.copyWith(formStatus: FormStatus.success));
        contactsCubit.loadContacts(null);
      },
    );
  }

  Future<void> updateContact() async {
    emit(state.copyWith(formStatus: FormStatus.inProgress));

    Contact contact = Contact(
      id: state.id,
      name: state.name!,
      idNumber: state.idNumber,
      email: state.email!,
      phone: state.phone!,
      address: state.address!,
      type: state.type!,
      accountNumber: state.accountNumber,
      accountHolderName: state.accountHolderName,
      bankName: state.bankName,
      taxNumber: state.taxNumber,
      details: state.details,
    );

    final failureOrContact = await updateContactUseCase.execute(
      UpdateContactParams(contact: contact),
    );

    failureOrContact.fold(
      (failure) =>
          emit(state.copyWith(failure: failure, formStatus: FormStatus.failed)),
      (contact) {
        emit(state.copyWith(formStatus: FormStatus.success));
        contactsCubit.loadContacts(null);
      },
    );
  }

  void updateName(String? name) {
    emit(state.copyWith(name: name));
  }

  void updateIdNumber(String? idNumber) {
    emit(state.copyWith(idNumber: idNumber));
  }

  void updateEmail(String? email) {
    emit(state.copyWith(email: email));
  }

  void updatePhone(String? phone) {
    emit(state.copyWith(phone: phone));
  }

  void updateAddress(String? address) {
    emit(state.copyWith(address: address));
  }

  void updateType(ContactType? type) {
    emit(state.copyWith(type: type));
  }

  void updateAccountNumber(String? accountNumber) {
    emit(state.copyWith(accountNumber: accountNumber));
  }

  void updateAccountHolderName(String? accountHolderName) {
    emit(state.copyWith(accountHolderName: accountHolderName));
  }

  void updateBankName(String? bankName) {
    emit(state.copyWith(bankName: bankName));
  }

  void updateTaxNumber(String? taxNumber) {
    emit(state.copyWith(taxNumber: taxNumber));
  }

  void updateDetails(String? details) {
    emit(state.copyWith(details: details));
  }

  void updateAutovalidateMode(AutovalidateMode? autovalidateMode) {
    emit(state.copyWith(autovalidateMode: autovalidateMode));
  }
}
