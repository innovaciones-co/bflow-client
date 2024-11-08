import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/extensions/string_utils_extension.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_type.dart';
import 'package:bflow_client/src/features/contacts/domain/usecases/delete_contact_usecase.dart';
import 'package:bflow_client/src/features/contacts/domain/usecases/get_contacts_usecase.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  final GetContactsUseCase getContactsUseCase;
  final DeleteContactUseCase deleteContactUseCase;
  final HomeBloc? homeBloc;

  ContactsCubit({
    required this.getContactsUseCase,
    this.homeBloc,
    required this.deleteContactUseCase,
  }) : super(ContactsInitial());

  void loadContacts(ContactType? type) async {
    emit(ContactsLoading());

    var params = GetContactsParams(contactType: type);
    final contactsUseCase = await getContactsUseCase.execute(params);
    contactsUseCase.fold(
      (l) => emit(ContactsError(failure: l)),
      (r) => emit(ContactsLoaded(contacts: r, contactsFiltered: r)),
    );
  }

  deleteContact(int id) async {
    var response =
        await deleteContactUseCase.execute(DeleteContactParams(id: id));

    response.fold(
      (failure) => homeBloc?.add(
        ShowMessageEvent(
          message: "Contact couldn't be deleted: ${failure.message}",
          type: AlertType.error,
        ),
      ),
      (_) {
        loadContacts(null);
        homeBloc?.add(
          ShowMessageEvent(
              message: "Contact has been deleted!", type: AlertType.success),
        );
      },
    );
  }

  filterContacts(String value) async {
    final contacts = (state as ContactsLoaded).contacts;

    if (value.isNotEmpty) {
      List<Contact> contactsFiltered =
          contacts.where((contact) => contact.name.search(value)).toList();

      emit((state as ContactsLoaded).copyWith(
        contactsFiltered: contactsFiltered,
      ));
    } else {
      emit((state as ContactsLoaded).copyWith(
        contactsFiltered: contacts,
      ));
    }
  }
}
