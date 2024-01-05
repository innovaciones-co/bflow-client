import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/routes/routes.dart';
import 'package:flutter/material.dart';

class SideMenuWidget extends StatelessWidget {
  const SideMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.colorScheme.surface,
      constraints: const BoxConstraints(maxWidth: 50),
      height: double.infinity,
      child: ListView(
        children: [
          _menuItem(context, Icons.search_outlined, RoutesName.initial),
          _menuItem(context, Icons.work, RoutesName.jobs),
          _menuItem(context, Icons.people_alt_outlined, RoutesName.jobs),
          _menuItem(context, Icons.logout_outlined, RoutesName.login),
        ],
      ),
    );
  }

  Widget _menuItem(BuildContext context, IconData icon, String routeName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: IconButton(
        onPressed: () => Navigator.of(context).pushNamed(routeName),
        icon: Icon(icon),
      ),
    );
  }
}
