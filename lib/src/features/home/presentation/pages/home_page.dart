import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const Text("This is the body"),
      floatingActionButton: FloatingActionButton(
        onPressed: () => debugPrint("Hola"),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // T
    );
  }
}
