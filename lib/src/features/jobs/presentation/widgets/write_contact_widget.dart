import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/domain/entities/form_status.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/utils/mixins/validator.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/dropdown_widget.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/core/widgets/input_widget.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_type.dart';
import 'package:bflow_client/src/features/contacts/presentation/cubit/contacts_cubit.dart';
import 'package:bflow_client/src/features/contacts/presentation/cubit/write_contact/write_contact_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WriteContactWidget extends StatelessWidget with Validator {
  final ContactsCubit contactsCubit;
  final Contact? contact;

  WriteContactWidget({super.key, required this.contactsCubit, this.contact});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WriteContactCubit>(
      create: (context) => WriteContactCubit(
        contactsCubit: contactsCubit,
        createContactUseCase: DependencyInjection.sl(),
        updateContactUseCase: DependencyInjection.sl(),
      )..initFormFromContact(contact),
      child: BlocConsumer<WriteContactCubit, WriteContactState>(
        listener: (context, state) {
          if (state.formStatus == FormStatus.success) {
            context.showAlert(message: "The user was created successfully");

            if (context.canPop()) {
              context.pop();
            }
          }
        },
        builder: (context, state) {
          WriteContactCubit contactCubit = context.read<WriteContactCubit>();

          return Form(
            key: _formKey,
            autovalidateMode: state.autovalidateMode,
            child: ListView(
              children: [
                state.formStatus == FormStatus.failed && state.failure != null
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(10),
                        color: AppColor.red,
                        child: FailureWidget(
                          failure: state.failure!,
                          textColor: Colors.white,
                        ),
                      )
                    : const SizedBox.shrink(),
                InputWidget(
                  label: "Name",
                  validator: validateName,
                  keyboardType: TextInputType.name,
                  initialValue: state.name,
                  onChanged: contactCubit.updateName,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: InputWidget(
                        label: "Email",
                        validator: validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        initialValue: state.email,
                        onChanged: contactCubit.updateEmail,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: InputWidget(
                        label: "Phone number",
                        hintText: '+1234567890',
                        validator: validatePhone,
                        keyboardType: TextInputType.phone,
                        initialValue: state.phone,
                        onChanged: contactCubit.updatePhone,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                InputWidget(
                  label: "Address",
                  validator: validateAddress,
                  keyboardType: TextInputType.streetAddress,
                  initialValue: state.address,
                  onChanged: contactCubit.updateAddress,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: InputWidget(
                        label: "ID Number",
                        initialValue: state.idNumber,
                        onChanged: contactCubit.updateIdNumber,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: DropdownWidget<ContactType>(
                        label: "Type",
                        items: ContactType.values,
                        getLabel: (c) => c.name,
                        onChanged: contactCubit.updateType,
                        initialValue: state.type,
                        validator: validateContactType,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                state.type == ContactType.client
                    ? const SizedBox.shrink()
                    : Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: InputWidget(
                                  label: "Account number",
                                  initialValue: state.accountNumber,
                                  onChanged: contactCubit.updateAccountNumber,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: InputWidget(
                                  label: "Holder name",
                                  keyboardType: TextInputType.name,
                                  initialValue: state.accountHolderName,
                                  onChanged:
                                      contactCubit.updateAccountHolderName,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: InputWidget(
                                  label: "Bank name",
                                  initialValue: state.bankName,
                                  onChanged: contactCubit.updateBankName,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: InputWidget(
                                  label: "ABN number",
                                  initialValue: state.taxNumber,
                                  onChanged: contactCubit.updateTaxNumber,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          InputWidget(
                            label: "Details",
                            initialValue: state.details,
                            onChanged: contactCubit.updateDetails,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ActionButtonWidget(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      type: ButtonType.textButton,
                      title: "Cancel",
                      paddingHorizontal: 15,
                      paddingVertical: 18,
                    ),
                    const SizedBox(width: 12),
                    contact == null
                        ? ActionButtonWidget(
                            onPressed: () =>
                                _createContact(context, contactCubit),
                            inProgress:
                                state.formStatus == FormStatus.inProgress,
                            type: ButtonType.elevatedButton,
                            title: "Create Contact",
                            backgroundColor: AppColor.blue,
                            foregroundColor: AppColor.white,
                          )
                        : ActionButtonWidget(
                            onPressed: () =>
                                _updateContact(context, contactCubit),
                            inProgress:
                                state.formStatus == FormStatus.inProgress,
                            type: ButtonType.elevatedButton,
                            title: "Save Contact",
                            backgroundColor: AppColor.blue,
                            foregroundColor: AppColor.white,
                          ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  _createContact(BuildContext context, WriteContactCubit contactCubit) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<WriteContactCubit>(context).createContact();
    } else {
      contactCubit.updateAutovalidateMode(AutovalidateMode.always);
    }
  }

  _updateContact(BuildContext context, WriteContactCubit contactCubit) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<WriteContactCubit>(context).updateContact();
    } else {
      contactCubit.updateAutovalidateMode(AutovalidateMode.always);
    }
  }
}
