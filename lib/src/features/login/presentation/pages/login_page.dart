import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          context.isDesktop ? Expanded(
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
                        image: AssetImage('assets/img/background_login.png'),
                        fit: BoxFit.cover
                      )
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
            ),
          ) : const SizedBox.shrink(),
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
                    const Text(
                      "Please enter your details",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 25),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text("User"),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.grey, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                        ),
                        //contentPadding: const EdgeInsets.all(10),
                        isDense: true,
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "",
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text("Password"),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.grey, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                        ),
                        //contentPadding: const EdgeInsets.all(10),
                        isDense: true,
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "",
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          minimumSize: const Size.fromHeight(60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Log in',
                        ),
                      ),
                    ),
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