import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/domain/entities/form_status.dart';
import 'package:bflow_client/src/core/utils/mixins/validator.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/dropdown_widget.dart';
import 'package:bflow_client/src/core/widgets/input_widget.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_role.dart';
import 'package:bflow_client/src/features/users/presentation/bloc/write_user/write_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WriteUserWidget extends StatelessWidget with Validator {
  final _formKey = GlobalKey<FormState>();

  WriteUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WriteUserCubit>(
      create: (context) => DependencyInjection.sl(),
      child: BlocBuilder<WriteUserCubit, WriteUserState>(
        builder: (context, state) {
          WriteUserCubit userCubit = context.read<WriteUserCubit>();

          if (state.formStatus == FormStatus.inProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          return Form(
            key: _formKey,
            autovalidateMode: state.autovalidateMode,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InputWidget(
                        label: "First Name",
                        validator: validateName,
                        onChanged: userCubit.changeFirstName,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: InputWidget(
                        label: "Last Name",
                        validator: validateLastName,
                        onChanged: userCubit.changeFirstName,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                InputWidget(
                  label: "Email",
                  validator: validateEmail,
                  onChanged: userCubit.changeEmail,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: InputWidget(
                        label: "Username",
                        validator: validateUsername,
                        onChanged: userCubit.changeFirstName,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: DropdownWidget<UserRole>(
                        label: "Role",
                        items: state.roles,
                        getLabel: (s) => s.name,
                        onChanged: null,
                        initialValue: state.role,
                        validator: validateRole,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
                      onPressed: () => _createUser(context),
                      type: ButtonType.elevatedButton,
                      title: "Create User",
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

  _createUser(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<WriteUserCubit>(context).createUser();
    }
  }
}
