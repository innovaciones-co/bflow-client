import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/routes/names.dart';
import 'package:bflow_client/src/core/utils/mixins/validator.dart';
import 'package:bflow_client/src/features/login/presentation/bloc/login/login_cubit.dart';
import 'package:bflow_client/src/features/login/presentation/widgets/login_form_widget.dart';
import 'package:bflow_client/src/features/login/presentation/widgets/reset_password_widget.dart';
import 'package:flutter/material.dart';
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
                child: LayoutBuilder(
                  builder: (context, state) {
                    double height = context.height / 8;

                    if (!(context.isMobile || context.isSmallTablet)) {
                      return Container(
                        constraints: const BoxConstraints(maxWidth: 500),
                        padding: const EdgeInsets.all(35),
                        child: _loginBody(height, context),
                      );
                    }

                    return Stack(
                      children: [
                        Positioned(
                          right: 0,
                          left: 0,
                          top: 0,
                          bottom: height * 6,
                          child: Container(
                            color: AppColor.black,
                            padding: const EdgeInsets.all(15),
                            child: Image.asset(
                              'assets/img/sh_logo_and_text.png',
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: height * 6,
                            constraints: const BoxConstraints(maxWidth: 500),
                            padding: const EdgeInsets.all(35),
                            child: _loginBody(height, context),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _loginBody(double height, BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: TabBarView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              LoginFormWidget(
                onForgotPassword: () => _controller.animateTo(1),
              ),
              ResetPasswordWidget(
                onBackPressed: () => _controller.animateTo(0),
              ),
            ],
          ),
        ),
        SizedBox(
          height:
              height * (context.isMobile || context.isSmallTablet ? 0.5 : 1),
          child: _versionInfo(),
        ),
      ],
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
}
