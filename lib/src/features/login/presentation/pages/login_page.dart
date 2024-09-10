import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/routes/names.dart';
import 'package:bflow_client/src/core/utils/mixins/validator.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/input_widget.dart';
import 'package:bflow_client/src/features/login/presentation/bloc/login/login_bloc.dart';
import 'package:bflow_client/src/features/login/presentation/bloc/recover-password/request_password_update_cubit.dart';
import 'package:bflow_client/src/features/login/presentation/widgets/reset_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/domain/entities/form_status.dart';

class LoginPage extends StatefulWidget with Validator {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with Validator, TickerProviderStateMixin {
  final _loginFormKey = GlobalKey<FormState>();
  late final TabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginFormState>(
        listener: (context, state) {
          if (state.status == FormStatus.success) {
            context.go(RoutesName.initial);
          }
          if (state.status == FormStatus.failed) {
            context.read<LoginCubit>().updateStatus(FormStatus.initialized);
            context.showAlert(
              message: state.errorMessage ?? "Unexpected error.",
              type: AlertType.error,
            );
          }
        },
        child: Row(
          children: [
            context.isDesktop
                ? Expanded(
                    flex: 1,
                    child: _backgroungWithLogo(),
                  )
                : const SizedBox.shrink(),
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  margin: const EdgeInsets.symmetric(horizontal: 35),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double height = context.height / 8;
                      return Column(
                        children: [
                          SizedBox(
                            height: height,
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            height: height * 6,
                            child: TabBarView(
                              controller: _controller,
                              children: [
                                _loginForm(context),
                                ResetPasswordWidget(
                                  onBackPressed: () => _controller.animateTo(0),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height,
                            child: _versionInfo(),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stack _backgroungWithLogo() {
    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/img/background_login.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          child: Container(
            height: 300,
            width: 380,
            decoration: BoxDecoration(
              color: const Color(0x80000000).withOpacity(0.6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset('assets/img/sh_logo_and_text.png'),
          ),
        ),
      ],
    );
  }

  FutureBuilder<PackageInfo> _versionInfo() {
    return FutureBuilder(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: Text(
              "Version : ${snapshot.data?.version}",
              style: context.labelSmall,
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _loginForm(BuildContext context) {
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
                const SizedBox(height: 35),
                const Text(
                  "Please enter your details",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 25),
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
                const SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.only(
                    right: context.isDesktop ? 20 : 0,
                    left: context.isDesktop ? 20 : 0,
                  ),
                  child: ActionButtonWidget(
                    onPressed: () {
                      TextInput.finishAutofillContext();

                      if (_loginFormKey.currentState != null &&
                          _loginFormKey.currentState!.validate()) {
                        loginBloc.login();
                      } else {
                        loginBloc
                            .updateAutovalidateMode(AutovalidateMode.always);
                      }
                    },
                    type: ButtonType.elevatedButton,
                    title: "Log in",
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    paddingVertical: 24,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        _controller.animateTo(1);
                      },
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
