part of 'contacts_cubit.dart';

abstract class ContactsState extends Equatable {
  const ContactsState();

  @override
  List<Object> get props => [];
}

class ContactsInitial extends ContactsState {}

class ContactsLoading extends ContactsState {}

class ContactsLoaded extends ContactsState {
  final List<Contact> contacts;
  final List<Contact> contactsFiltered;

  const ContactsLoaded({
    required this.contacts,
    this.contactsFiltered = const [],
  });

  @override
  List<Object> get props => [
        contacts,
        contactsFiltered,
      ];

  ContactsLoaded copyWith({
    List<Contact>? contacts,
    List<Contact>? contactsFiltered,
  }) {
    return ContactsLoaded(
      contacts: contacts ?? this.contacts,
      contactsFiltered: contactsFiltered ?? this.contactsFiltered,
    );
  }
}

class ContactsError extends ContactsState {
  final Failure failure;

  const ContactsError({required this.failure});

  @override
  List<Object> get props => [failure];
}
