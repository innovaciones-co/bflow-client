import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/routes/routes.dart';
import 'package:bflow_client/src/core/utils/mixins/validator.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/input_widget.dart';
import 'package:bflow_client/src/features/login/presentation/bloc/recover-password/request_password_update_cubit.dart';
import 'package:bflow_client/src/features/login/presentation/bloc/recover-password/update_password_cubit.dart';
import 'package:bflow_client/src/features/login/presentation/bloc/recover-password/update_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UpdatePasswordWidget extends StatelessWidget with Validator {
  final Function()? onSuccess;

  const UpdatePasswordWidget({super.key, this.onSuccess});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController tokenController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    return BlocProvider(
      create: (context) =>
          UpdatePasswordCubit(updatePasswordUseCase: DependencyInjection.sl()),
      child: BlocListener<UpdatePasswordCubit, UpdatePasswordState>(
        listener: (context, state) {
          if (state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message!),
              backgroundColor: AppColor.green,
            ));
            tokenController.text = '';
            passwordController.text = '';
            confirmPasswordController.text = '';
            if (onSuccess != null) {
              onSuccess!();
            }
          } else if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error!.message ?? 'Unexpected error'),
              backgroundColor: AppColor.red,
            ));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                InputWidget(
                  controller: tokenController,
                  label: "Token",
                  validator: validateToken,
                  autofillHints: const [AutofillHints.oneTimeCode],
                ),
                const SizedBox(height: 25),
                InputWidget(
                  controller: passwordController,
                  label: "New password",
                  validator: validatePassword,
                  autofillHints: const [AutofillHints.password],
                  obscureText: true,
                ),
                const SizedBox(height: 25),
                InputWidget(
                  controller: confirmPasswordController,
                  label: "Confirm password",
                  validator: (value) =>
                      validateConfirmPassword(value, passwordController.text),
                  autofillHints: const [AutofillHints.password],
                  obscureText: true,
                ),
                const SizedBox(height: 50),
                BlocBuilder<UpdatePasswordCubit, UpdatePasswordState>(
                  builder: (context, state) {
                    return ActionButtonWidget(
                      inProgress: state.isLoading,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<UpdatePasswordCubit>(context)
                              .updatePassword(
                            tokenController.text,
                            passwordController.text,
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
      ),
    );
  }
}
