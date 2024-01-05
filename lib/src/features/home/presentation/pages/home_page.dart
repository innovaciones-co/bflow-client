import 'package:bflow_client/src/core/routes/routes.dart';
import 'package:bflow_client/src/features/jobs/presentation/pages/pages.dart';
import 'package:flutter/material.dart';

import '../widgets/app_bar_widget.dart';
import '../widgets/side_menu_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: const Row(
        children: [
          SideMenuWidget(),
          Expanded(
            child: JobsPage(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutesName.login);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // T
    );
  }
}
