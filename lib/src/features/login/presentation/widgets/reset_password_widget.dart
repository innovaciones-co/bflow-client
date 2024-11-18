import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/utils/mixins/validator.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/input_widget.dart';
import 'package:bflow_client/src/features/login/presentation/bloc/recover-password/request_password_update_cubit.dart';
import 'package:bflow_client/src/features/login/presentation/widgets/update_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordWidget extends StatefulWidget with Validator {
  final Function()? onBackPressed;

  ResetPasswordWidget({super.key, this.onBackPressed});

  @override
  State<ResetPasswordWidget> createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget>
    with Validator {
  final _passwordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RequestPasswordUpdateCubit>(
      create: (context) => DependencyInjection.sl(),
      child: Builder(builder: (context) {
        return BlocListener<RequestPasswordUpdateCubit,
            RequestPasswordUpdateState>(
          listener: (context, state) {
            if (state is RequestPasswordUpdateError) {
              context.showAlert(
                  message: state.failure.message!, type: AlertType.error);
            } else if (state is RequestPasswordUpdateDone) {
              if (state.message != null) {
                context.showAlert(
                    message: state.message!, type: AlertType.success);
              }
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: widget.onBackPressed,
                    icon: const Icon(Icons.arrow_back_ios_outlined),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Reset your password",
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              BlocSelector<RequestPasswordUpdateCubit,
                  RequestPasswordUpdateState, bool>(
                selector: (state) => state.tokenRequested,
                builder: (context, tokenRequested) {
                  return tokenRequested
                      ? UpdatePasswordWidget(
                          onSuccess: widget.onBackPressed,
                        )
                      : _requestTokenForm();
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _requestTokenForm() {
    return BlocSelector<RequestPasswordUpdateCubit, RequestPasswordUpdateState,
        AutovalidateMode>(
      bloc: DependencyInjection.sl(),
      selector: (state) {
        if (state is RequestPasswordUpdateInitial) {
          return state.autovalidateMode;
        }

        return AutovalidateMode.disabled;
      },
      builder: (context, autovalidateMode) {
        var requestPasswordUpdateBloc =
            context.read<RequestPasswordUpdateCubit>();

        return Form(
          key: _passwordFormKey,
          autovalidateMode: autovalidateMode,
          child: AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Please enter your details",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 25),
                InputWidget(
                  label: "Username",
                  onChanged: requestPasswordUpdateBloc.updateUsername,
                  validator: validateUsername,
                  //initialValue: requestPasswordUpdateBloc.state.username,
                  autofillHints: const [AutofillHints.username],
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.only(
                    right: context.isDesktop ? 20 : 0,
                    left: context.isDesktop ? 20 : 0,
                  ),
                  child: BlocSelector<RequestPasswordUpdateCubit,
                      RequestPasswordUpdateState, bool>(
                    selector: (state) {
                      return state is RequestPasswordUpdateLoading;
                    },
                    builder: (context, isLoading) {
                      return ActionButtonWidget(
                        inProgress: isLoading,
                        onPressed: () {
                          TextInput.finishAutofillContext();

                          if (_passwordFormKey.currentState != null &&
                              _passwordFormKey.currentState!.validate()) {
                            requestPasswordUpdateBloc.requestToken();
                          } else {
                            requestPasswordUpdateBloc.updateAutovalidateMode(
                                AutovalidateMode.always);
                          }
                        },
                        type: ButtonType.elevatedButton,
                        title: "Request token",
                        backgroundColor: AppColor.blue,
                        foregroundColor: AppColor.white,
                        paddingVertical: 24,
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Center(
                    child: TextButton(
                      onPressed: () =>
                          requestPasswordUpdateBloc.tokenRequested(true),
                      child: const Text("I already have a token"),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
