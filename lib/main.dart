import 'package:flutter/material.dart';

import 'bflow.dart';
import 'src/core/config/config.dart';

Future<void> main() async {
  // Test commit
  // Other
  await DependencyInjection.init();
  runApp(const BflowApp());
}
