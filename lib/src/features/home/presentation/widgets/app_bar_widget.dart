import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/routes/routes.dart';
import 'package:bflow_client/src/features/login/presentation/bloc/login/login_bloc.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
        FutureBuilder(
          future: context.read<LoginCubit>().getLoggedUser(),
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.hasData) {
              User? user = snapshot.data;
              if (user != null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${user.firstName} ${user.lastName}",
                      style: context.bodyMedium?.copyWith(
                        color: AppColor.grey,
                      ),
                    ),
                    Text(
                      user.role.toString(),
                      style: context.bodySmall?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              }
            }

            return const SizedBox.shrink();
          },
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: () => _logout(context),
          icon: Icon(
            Icons.logout_outlined,
            color: AppColor.grey,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);

  _logout(BuildContext context) async {
    bool loggedOut = await context.read<LoginCubit>().logout();
    if (!context.mounted) return;

    if (loggedOut) {
      context.go(RoutesName.login);
    } else {
      context.showAlert(
        message: "Unexpected error when loggin out",
        type: AlertType.error,
      );
    }
  }
}
