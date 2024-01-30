import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/input_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
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
                                      'assets/img/background_login.png'),
                                  fit: BoxFit.cover)),
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
                  ),
                )
              : const SizedBox.shrink(),
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                margin: const EdgeInsets.symmetric(horizontal: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Welcome back!",
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 35),
                    Text(
                      "Please enter your details",
                      style: TextStyle(fontSize: 16, color: AppColor.darkGrey),
                    ),
                    const SizedBox(height: 25),
                    const InputWidget(
                      label: "User",
                    ),
                    const SizedBox(height: 20),
                    const InputWidget(label: "Password", obscureText: true),
                    const SizedBox(height: 20),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, right: 20, left: 20),
                      child: ActionButtonWidget(
                        onPressed: () {},
                        type: ButtonType.elevatedButton,
                        title: "Log in",
                        backgroundColor: AppColor.blue,
                        foregroundColor: AppColor.white,
                        paddingVertical: 24,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
