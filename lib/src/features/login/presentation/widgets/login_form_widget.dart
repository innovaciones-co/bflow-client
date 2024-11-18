import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/utils/mixins/validator.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login/login_cubit.dart';

class LoginFormWidget extends StatefulWidget {
  final Function()? onForgotPassword;
  const LoginFormWidget({super.key, this.onForgotPassword});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> with Validator {
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginCubit, LoginFormState, AutovalidateMode>(
      bloc: DependencyInjection.sl(),
      selector: (state) => state.autovalidateMode,
      builder: (context, autovalidateMode) {
        var loginBloc = context.read<LoginCubit>();
        return Form(
          key: _loginFormKey,
          autovalidateMode: autovalidateMode,
          child: AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Welcome back!",
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(
                    height:
                        context.isMobile || context.isSmallTablet ? 25 : 35),
                const Text(
                  "Please enter your details",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(
                    height:
                        context.isMobile || context.isSmallTablet ? 20 : 25),
                InputWidget(
                  label: "Username",
                  onChanged: loginBloc.updateUsername,
                  validator: validateName,
                  initialValue: loginBloc.state.username,
                  autofillHints: const [AutofillHints.username],
                ),
                const SizedBox(height: 20),
                InputWidget(
                  label: "Password",
                  obscureText: true,
                  onChanged: loginBloc.updatePassword,
                  validator: validatePassword,
                  initialValue: loginBloc.state.password,
                  autofillHints: const [AutofillHints.password],
                  onFieldSubmitted: (pass) {
                    TextInput.finishAutofillContext();

                    if (_loginFormKey.currentState != null &&
                        _loginFormKey.currentState!.validate()) {
                      loginBloc.login();
                    } else {
                      loginBloc.updateAutovalidateMode(AutovalidateMode.always);
                    }
                  },
                ),
                SizedBox(
                    height:
                        context.isMobile || context.isSmallTablet ? 25 : 50),
                Padding(
                  padding: EdgeInsets.only(
                    right: context.isDesktop ? 20 : 0,
                    left: context.isDesktop ? 20 : 0,
                  ),
                  child: BlocSelector<LoginCubit, LoginFormState, bool>(
                    selector: (state) {
                      return state.isLoading;
                    },
                    builder: (context, isLoading) {
                      return ActionButtonWidget(
                        onPressed: () {
                          TextInput.finishAutofillContext();

                          if (_loginFormKey.currentState != null &&
                              _loginFormKey.currentState!.validate()) {
                            loginBloc.login();
                          } else {
                            loginBloc.updateAutovalidateMode(
                                AutovalidateMode.onUserInteraction);
                          }
                        },
                        type: ButtonType.elevatedButton,
                        title: "Log in",
                        backgroundColor: AppColor.blue,
                        foregroundColor: Colors.white,
                        paddingVertical: 24,
                        inProgress: isLoading,
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: context.isMobile || context.isSmallTablet ? 10 : 15),
                  child: Center(
                    child: TextButton(
                      onPressed: widget.onForgotPassword,
                      child: const Text("Forgot password?"),
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
