import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/core/widgets/page_container_widget.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_type.dart';
import 'package:bflow_client/src/features/contacts/presentation/cubit/contacts_cubit.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/write_contact_widget.dart';
import 'package:bflow_client/src/features/shared/presentation/widgets/table_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactsCubit>(
      create: (context) => DependencyInjection.sl()..loadContacts(null),
      child: PageContainerWidget(
        title: 'Contacts',
        actions: [
          Builder(builder: (context) {
            return ActionButtonWidget(
              onPressed: () => context.showLeftDialog(
                "New Contact",
                WriteContactWidget(
                  contactsCubit: context.read(),
                ),
              ),
              type: ButtonType.elevatedButton,
              title: "New contact",
              backgroundColor: AppColor.blue,
              foregroundColor: AppColor.white,
              icon: Icons.add,
            );
          }),
        ],
        child: BlocBuilder<ContactsCubit, ContactsState>(
          builder: (context, state) {
            if (state is ContactsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ContactsError) {
              return FailureWidget(
                failure: state.failure,
              );
            }
            if (state is ContactsLoaded) {
              var contacts = state.contacts;
              return DefaultTabController(
                length: ContactType.values.length,
                child: Column(
                  children: [
                    TabBar(
                      tabs: ContactType.values
                          .map((e) => Tab(text: e.name))
                          .toList(),
                      labelColor: AppColor.blue,
                      indicatorColor: AppColor.blue,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 3,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: ContactType.values
                            .map(
                              (e) => _contactsTable(
                                context,
                                contacts.where((c) => c.type == e).toList(),
                              ),
                            )
                            .toList(),
                      ),
                    )
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _contactsTable(BuildContext context, List<Contact> contacts) {
    return SingleChildScrollView(
      child: Table(
        border: TableBorder.all(
          color: AppColor.grey,
        ),
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: AppColor.grey,
            ),
            children: const [
              TableHeaderWidget(label: "Name"),
              TableHeaderWidget(label: "Email"),
              TableHeaderWidget(label: "Address"),
              TableHeaderWidget(label: "Actions"),
            ],
          ),
          ...contacts.map(
            (e) => TableRow(
              decoration: BoxDecoration(
                color: AppColor.white,
              ),
              children: [
                _tableData(context, e.name),
                _tableData(context, e.email),
                _tableData(context, e.address),
                _tableActions(context, e), // TODO: check
              ],
            ),
          )
        ],
      ),
    );
  }

  _tableData(BuildContext context, String label) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Text(label, style: context.bodyMedium),
      ),
    );
  }

  _tableActions(BuildContext context, Contact contact) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => context.showLeftDialog(
                "Edit Contact",
                WriteContactWidget(
                  contactsCubit: context.read(),
                  contact: contact,
                ),
              ),
              color: AppColor.blue,
              icon: const Icon(Icons.edit_outlined),
              tooltip: 'Edit',
            ),
            Builder(builder: (context) {
              return IconButton(
                onPressed: () =>
                    context.read<ContactsCubit>().deleteContact(contact.id!),
                color: AppColor.blue,
                icon: const Icon(
                  Icons.delete_outline_outlined,
                  size: 20,
                ),
                tooltip: 'Delete',
              );
            }),
            contact.type == ContactType.supplier
                ? IconButton(
                    onPressed: () {},
                    color: AppColor.blue,
                    icon: const Icon(
                      Icons.menu_book_outlined,
                      size: 20,
                    ),
                    tooltip: 'See Catalog',
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
