import 'package:bflow_client/src/core/config/injection.dart';
import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/routes/names.dart';
import 'package:bflow_client/src/core/utils/mixins/validator.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/input_widget.dart';
import 'package:bflow_client/src/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget with Validator {
  LoginPage({super.key});

  final _loginFormKey = GlobalKey<FormState>();

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
              message: state.errorMessage ?? "Unexpected error",
              type: AlertType.error,
            );
          }
        },
        child: Row(
          children: [
            context.isDesktop
                ? Expanded(
                    flex: 1,
                    child: Stack(
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
                            child:
                                Image.asset('assets/img/sh_logo_and_text.png'),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  margin: const EdgeInsets.symmetric(horizontal: 80),
                  child: _loginForm(context),
                ),
              ),
            ),
          ],
        ),
      ),
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
              ),
              const SizedBox(height: 20),
              InputWidget(
                label: "Password",
                obscureText: true,
                onChanged: loginBloc.updatePassword,
                validator: validatePassword,
                initialValue: loginBloc.state.password,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
                child: ActionButtonWidget(
                  onPressed: () {
                    if (_loginFormKey.currentState!.validate()) {
                      loginBloc.login();
                    } else {
                      loginBloc.updateAutovalidateMode(AutovalidateMode.always);
                    }
                  },
                  type: ButtonType.elevatedButton,
                  title: "Log in",
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  paddingVertical: 24,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
