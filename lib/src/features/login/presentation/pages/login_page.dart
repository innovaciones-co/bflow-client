import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Welcome back!", style: TextStyle(fontSize: 20),),
        const Text("Please enter your details", style: TextStyle(color: Colors.grey),),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text("User"),
        ),
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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text("Password"),
        ),
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
        Padding(
          padding: const EdgeInsets.only(top:30, right: 20, left: 20),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                //padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 20), // THIS no hace nada
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                minimumSize: const Size.fromHeight(60), // THIs full with?
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
    );
  }
}
