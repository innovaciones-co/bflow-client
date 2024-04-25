import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/domain/entities/form_status.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/utils/mixins/validator.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/dropdown_widget.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/core/widgets/input_widget.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_entity.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_role.dart';
import 'package:bflow_client/src/features/users/presentation/bloc/users_bloc.dart';
import 'package:bflow_client/src/features/users/presentation/bloc/write_user/write_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WriteUserWidget extends StatefulWidget {
  final UsersBloc usersBloc;
  final User? user;

  const WriteUserWidget({super.key, required this.usersBloc, this.user});

  @override
  State<WriteUserWidget> createState() => _WriteUserWidgetState();
}

class _WriteUserWidgetState extends State<WriteUserWidget> with Validator {
  bool obscurePass1 = true;
  bool obscurePass2 = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WriteUserCubit>(
      create: (context) => WriteUserCubit(
        createUserUseCase: DependencyInjection.sl(),
        updateUserUseCase: DependencyInjection.sl(),
        usersBloc: widget.usersBloc,
      )..initFormFromUser(widget.user),
      child: BlocConsumer<WriteUserCubit, WriteUserState>(
        listener: (context, state) {
          if (state.formStatus == FormStatus.success) {
            context.showAlert(message: "The user was created successfully");

            if (context.canPop()) {
              context.pop();
            }
          }
        },
        builder: (context, state) {
          WriteUserCubit userCubit = context.read<WriteUserCubit>();

          return Form(
            key: _formKey,
            autovalidateMode: state.autovalidateMode,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Row(
                  children: [
                    Expanded(
                      child: InputWidget(
                        label: "First Name",
                        validator: validateName,
                        initialValue: state.firstName,
                        onChanged: userCubit.changeFirstName,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: InputWidget(
                        label: "Last Name",
                        validator: validateLastName,
                        initialValue: state.lastName,
                        onChanged: userCubit.changeLastName,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                InputWidget(
                  label: "Email",
                  validator: validateEmail,
                  initialValue: state.email,
                  onChanged: userCubit.changeEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: InputWidget(
                        label: "Username",
                        validator: validateUsername,
                        initialValue: state.username,
                        onChanged: userCubit.changeUsername,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: DropdownWidget<UserRole>(
                        label: "Role",
                        items: state.roles,
                        getLabel: (s) => s.name,
                        onChanged: userCubit.changeRole,
                        initialValue: state.role,
                        validator: validateRole,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: InputWidget(
                        label: "Password",
                        validator: validatePassword,
                        onChanged: userCubit.changePassword,
                        obscureText: obscurePass1,
                        initialValue: state.password,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: InputWidget(
                        label: "Confirm password",
                        obscureText: obscurePass2,
                        validator: (value) => validateConfirmPassword(
                          value,
                          state.password ?? "",
                        ),
                        initialValue: state.password,
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
                    widget.user == null
                        ? ActionButtonWidget(
                            inProgress:
                                state.formStatus == FormStatus.inProgress,
                            onPressed: () => _createUser(context, userCubit),
                            type: ButtonType.elevatedButton,
                            title: "Create User",
                            backgroundColor: AppColor.blue,
                            foregroundColor: AppColor.white,
                          )
                        : ActionButtonWidget(
                            inProgress:
                                state.formStatus == FormStatus.inProgress,
                            onPressed: () => _updateUser(context, userCubit),
                            type: ButtonType.elevatedButton,
                            title: "Save User",
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

  _createUser(BuildContext context, WriteUserCubit userCubit) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<WriteUserCubit>(context).createUser();
    } else {
      userCubit.updateAutovalidateMode(AutovalidateMode.always);
    }
  }

  _updateUser(BuildContext context, WriteUserCubit userCubit) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<WriteUserCubit>(context).updateUser();
    } else {
      userCubit.updateAutovalidateMode(AutovalidateMode.always);
    }
  }
}
