import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  const AppBarWidget({super.key, this.height = kToolbarHeight});

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: Center(
        child: Row(
          children: [
            Image.asset(
              'assets/img/sh_logo.png',
              height: 50,
              width: 50,
            ),
            Image.asset(
              'assets/img/sh_text.png',
              height: 50,
              width: 100,
            ),
          ],
        ),
      ),
      actions: [
        Text(
          "Alberto",
          style: context.bodyMedium?.copyWith(
            color: context.onSecondary,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: null,
          icon: Icon(
            Icons.logout_outlined,
            color: context.onSecondary,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
