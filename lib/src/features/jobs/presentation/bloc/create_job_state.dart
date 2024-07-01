// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bflow_client/src/core/domain/entities/form_status.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CreateJobState extends Equatable {
  final FormStatus formStatus;
  final AutovalidateMode autovalidateMode;
  final String jobNumber;
  final String name;
  final String address;
  final User? supervisor;
  final User? owner;
  final Contact? client;
  final List<User> supervisors;
  final List<User> owners;
  final List<Contact> clients;
  final DateTime? startDate;
  final DateTime? endDate;
  final Failure? failure;

  const CreateJobState({
    this.formStatus = FormStatus.initialized,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.jobNumber = '',
    this.name = '',
    this.address = '',
    this.supervisor,
    this.owner,
    this.client,
    this.supervisors = const [],
    this.owners = const [],
    this.clients = const [],
    this.startDate,
    this.endDate,
    this.failure,
  });

  CreateJobState copyWith({
    FormStatus formStatus,
    AutovalidateMode autovalidateMode,
    String? jobNumber,
    String? name,
    String? address,
    User? supervisor,
    User? owner,
    Contact? client,
    List<User>? supervisors,
    List<User>? owners,
    List<Contact>? clients,
    DateTime? startDate,
    DateTime? endDate,
    Failure? failure,
  });

  @override
  List<Object?> get props => [
        formStatus,
        autovalidateMode,
        jobNumber,
        name,
        address,
        supervisor,
        owner,
        client,
        supervisors,
        owners,
        clients,
        startDate,
        endDate,
        failure,
      ];
}

class CreateJobValidator extends CreateJobState {
  const CreateJobValidator({
    super.formStatus = FormStatus.initialized,
    super.autovalidateMode = AutovalidateMode.disabled,
    super.jobNumber = '',
    super.name = '',
    super.address = '',
    super.supervisor,
    super.owner,
    super.client,
    super.supervisors = const [],
    super.owners = const [],
    super.clients = const [],
    super.startDate,
    super.endDate,
    super.failure,
  });

  @override
  CreateJobValidator copyWith({
    FormStatus? formStatus,
    AutovalidateMode? autovalidateMode,
    String? jobNumber,
    String? name,
    String? address,
    User? supervisor,
    User? owner,
    Contact? client,
    List<User>? supervisors,
    List<User>? owners,
    List<Contact>? clients,
    DateTime? startDate,
    DateTime? endDate,
    Failure? failure,
  }) {
    return CreateJobValidator(
      formStatus: formStatus ?? this.formStatus,
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      jobNumber: jobNumber ?? this.jobNumber,
      name: name ?? this.name,
      address: address ?? this.address,
      supervisor: supervisor ?? this.supervisor,
      owner: owner ?? this.owner,
      supervisors: supervisors ?? this.supervisors,
      owners: owners ?? this.owners,
      client: client ?? this.client,
      clients: clients ?? this.clients,
      failure: failure ?? this.failure,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
