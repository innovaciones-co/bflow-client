import 'package:bflow_client/src/core/theme/text_theme.dart';
import 'package:bflow_client/src/core/theme/theme.dart';

import 'package:flutter/material.dart';
import 'src/core/routes/routes.dart';

class BflowApp extends StatelessWidget {
  const BflowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MaterialTheme(textTheme(context)).light(),
      darkTheme: MaterialTheme(textTheme(context)).dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.initial,
      onGenerateRoute: AppRoute.generate,
    );
  }
}
