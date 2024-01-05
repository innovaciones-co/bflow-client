import 'src/core/config/config.dart';
import 'package:flutter/material.dart';
import 'bflow.dart';

Future<void> main() async {
  //  Here we are calling the Dependency Injection
  await DependencyInjection.init();
  //  This is the main app
  runApp(const BflowApp());
}
