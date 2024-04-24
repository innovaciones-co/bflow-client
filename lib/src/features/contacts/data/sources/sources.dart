import 'package:bflow_client/src/core/api/api.dart';
import 'package:bflow_client/src/core/data/sources/remote_data_source.dart';
import 'package:bflow_client/src/features/contacts/data/models/contact_model.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';

class ContactsRemoteDataSource extends RemoteDataSource {
  ContactsRemoteDataSource({required super.apiService});

  Future<List<ContactModel>> fetchContacts() async {
    List<dynamic> response =
        await apiService.get(endpoint: ApiConstants.contactsEndpoint);
    return response.map((e) => ContactModel.fromMap(e)).toList();
  }

  Future<void> deleteContact(int contactId) async {
    await apiService.delete(
        endpoint: ApiConstants.contactEndpoint
            .replaceAll(':id', contactId.toString()));
  }

  Future<ContactModel> fetchContact(int contactId) async {
    Map<String, dynamic> response = await apiService.get(
        endpoint: ApiConstants.contactEndpoint
            .replaceAll(':id', contactId.toString()));

    return ContactModel.fromMap(response);
  }

  Future<ContactModel> updateContact(Contact contact) async {
    final contactModel = ContactModel.fromEntity(contact);
    int contactId = await apiService.put(
      endpoint: ApiConstants.contactEndpoint
          .replaceAll(':id', contactModel.id!.toString()),
      data: contactModel.toMap(),
    );

    return fetchContact(contactId);
  }

  Future<ContactModel> createContact(Contact contact) async {
    final contactModel = ContactModel.fromEntity(contact);
    int contactId = await apiService.post(
      endpoint: ApiConstants.contactsEndpoint,
      data: contactModel.toMap(),
    );

    return fetchContact(contactId);
  }
}
