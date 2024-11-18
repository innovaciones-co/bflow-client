import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/utils/mixins/validator.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/input_widget.dart';
import 'package:bflow_client/src/features/login/presentation/bloc/recover-password/request_password_update_cubit.dart';
import 'package:bflow_client/src/features/login/presentation/bloc/recover-password/update_password_cubit.dart';
import 'package:bflow_client/src/features/login/presentation/bloc/recover-password/update_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePasswordWidget extends StatefulWidget with Validator {
  final Function()? onSuccess;

  const UpdatePasswordWidget({super.key, this.onSuccess});

  @override
  State<UpdatePasswordWidget> createState() => _UpdatePasswordWidgetState();
}

class _UpdatePasswordWidgetState extends State<UpdatePasswordWidget>
    with Validator {
  final _updatePasswordFormKey = GlobalKey<FormState>();
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UpdatePasswordCubit(updatePasswordUseCase: DependencyInjection.sl()),
      child: BlocListener<UpdatePasswordCubit, UpdatePasswordState>(
        listener: (context, state) {
          if (state.message != null) {
            context.showAlert(message: state.message!, type: AlertType.success);
            _tokenController.text = '';
            _passwordController.text = '';
            _confirmPasswordController.text = '';
            if (widget.onSuccess != null) {
              widget.onSuccess!();
            }
          } else if (state.error != null) {
            context.showAlert(
                message: state.error!.message ?? 'Unexpected error',
                type: AlertType.error);
          }
        },
        child: Form(
          key: _updatePasswordFormKey,
          child: Column(
            children: [
              InputWidget(
                controller: _tokenController,
                label: "Token",
                validator: validateToken,
                autofillHints: const [AutofillHints.oneTimeCode],
              ),
              const SizedBox(height: 15),
              InputWidget(
                controller: _passwordController,
                label: "New password",
                validator: validatePassword,
                autofillHints: const [AutofillHints.password],
                obscureText: true,
              ),
              const SizedBox(height: 15),
              InputWidget(
                controller: _confirmPasswordController,
                label: "Confirm password",
                validator: (value) =>
                    validateConfirmPassword(value, _passwordController.text),
                autofillHints: const [AutofillHints.password],
                obscureText: true,
              ),
              const SizedBox(height: 20),
              BlocBuilder<UpdatePasswordCubit, UpdatePasswordState>(
                builder: (context, state) {
                  return ActionButtonWidget(
                    inProgress: state.isLoading,
                    onPressed: () {
                      if (_updatePasswordFormKey.currentState!.validate()) {
                        BlocProvider.of<UpdatePasswordCubit>(context)
                            .updatePassword(
                          _tokenController.text,
                          _passwordController.text,
                        );
                      }
                    },
                    type: ButtonType.elevatedButton,
                    title: 'Update Password',
                    backgroundColor: AppColor.blue,
                    foregroundColor: AppColor.white,
                  );
                },
              ),
              Builder(builder: (context) {
                var requestPasswordUpdateBloc =
                    context.read<RequestPasswordUpdateCubit>();
                return Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Center(
                    child: TextButton(
                      onPressed: () =>
                          requestPasswordUpdateBloc.tokenRequested(false),
                      child: const Text("Request a new token"),
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
