import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/domain/entities/form_status.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/utils/mixins/validator.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/dropdown_widget.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/core/widgets/input_widget.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_type.dart';
import 'package:bflow_client/src/features/contacts/presentation/cubit/contacts_cubit.dart';
import 'package:bflow_client/src/features/contacts/presentation/cubit/write_contact/write_contact_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WriteContactWidget extends StatelessWidget with Validator {
  final ContactsCubit contactsCubit;

  WriteContactWidget({super.key, required this.contactsCubit});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WriteContactCubit>(
      create: (context) => WriteContactCubit(
        contactsCubit: contactsCubit,
        createContactUseCase: DependencyInjection.sl(),
      ),
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
                  onChanged: contactCubit.updateAddress,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: InputWidget(
                        label: "ID Number",
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
                        initialValue: ContactType.client,
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
                                  onChanged: contactCubit.updateAccountNumber,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: InputWidget(
                                  label: "Holder name",
                                  keyboardType: TextInputType.name,
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
                                  onChanged: contactCubit.updateBankName,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: InputWidget(
                                  label: "Tax number",
                                  onChanged: contactCubit.updateTaxNumber,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          InputWidget(
                            label: "Details",
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
                    ActionButtonWidget(
                      onPressed: () => _createContact(context, contactCubit),
                      inProgress: state.formStatus == FormStatus.inProgress,
                      type: ButtonType.elevatedButton,
                      title: "Create Contact",
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
}
