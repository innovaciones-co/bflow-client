import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_type.dart';
import 'package:bflow_client/src/features/contacts/domain/usecases/get_contacts_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  final GetContactsUseCase getContactsUseCase;
  ContactsCubit(this.getContactsUseCase) : super(ContactsInitial());

  void loadContacts(ContactType? type) async {
    emit(ContactsLoading());

    var params = GetContactsParams(contactType: type);
    final contactsUseCase = await getContactsUseCase.execute(params);
    contactsUseCase.fold(
      (l) => emit(ContactsError(failure: l)),
      (r) => emit(ContactsLoaded(contacts: r)),
    );
  }
}
