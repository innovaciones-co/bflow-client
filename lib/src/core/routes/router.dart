import 'dart:async';

import 'package:bflow_client/src/core/routes/routes.dart';
import 'package:bflow_client/src/features/catalog/presentation/pages/catalog_page.dart';
import 'package:bflow_client/src/features/catalog/presentation/pages/catalogs_page.dart';
import 'package:bflow_client/src/features/contacts/presentation/pages/contacts_page.dart';
import 'package:bflow_client/src/features/home/presentation/pages/home_page.dart';
import 'package:bflow_client/src/features/jobs/presentation/pages/job_page.dart';
import 'package:bflow_client/src/features/jobs/presentation/pages/jobs_page.dart';
import 'package:bflow_client/src/features/jobs/presentation/pages/task_confirmation_page.dart';
import 'package:bflow_client/src/features/login/presentation/bloc/login/login_bloc.dart';
import 'package:bflow_client/src/features/login/presentation/pages/login_page.dart';
import 'package:bflow_client/src/features/users/presentation/pages/users_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

const _pageKey = ValueKey('_pageKey');
const _scaffoldKey = ValueKey('_scaffoldKey');

const List<CustomNavigationDestination> homeDestinations = [
  CustomNavigationDestination(
    label: 'Jobs',
    icon: Icon(Icons.construction_outlined),
    route: RoutesName.initial,
    child: JobsPage(),
  ),
  CustomNavigationDestination(
    label: 'Users',
    icon: Icon(Icons.people_outlined),
    route: RoutesName.users,
    child: UsersPage(),
  ),
  CustomNavigationDestination(
    label: 'Contacts',
    icon: Icon(Icons.contact_page_outlined),
    route: RoutesName.contacts,
    child: ContactsPage(),
  ),
  CustomNavigationDestination(
    label: 'Catalogs',
    icon: Icon(Icons.menu_book_outlined),
    route: RoutesName.catalogs,
    child: CatalogsPage(),
  ),
];

class CustomNavigationDestination {
  const CustomNavigationDestination({
    required this.route,
    required this.label,
    required this.icon,
    this.child,
  });

  final String route;
  final String label;
  final Icon icon;
  final Widget? child;
}

final appRouter = GoRouter(
  routes: [
    // HomeScreen
    for (final route in homeDestinations)
      GoRoute(
        path: route.route,
        redirect: _isLoggedIn,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: _pageKey,
          child: HomePage(
            key: _scaffoldKey,
            currentIndex: homeDestinations.indexOf(route),
            child: route.child ?? const SizedBox.shrink(),
          ),
        ),
      ),
    // LoginScreen
    GoRoute(
      path: RoutesName.login,
      pageBuilder: (context, state) => MaterialPage<void>(
        key: _pageKey,
        child: LoginPage(
          key: _scaffoldKey,
        ),
      ),
    ),
    // TaskConfirmationScreen
    GoRoute(
        path: RoutesName.taskConfirmation,
        pageBuilder: (context, state) {
          final idStr = state.pathParameters["id"];
          final int? taskId = idStr != null ? int.tryParse(idStr) : null;

          if (taskId == null) {
            return const MaterialPage(
              key: _pageKey,
              child: Scaffold(
                key: _scaffoldKey,
                body: Text("Not found"), // TODO: replace with no found widget
              ),
            );
          }

          return MaterialPage<void>(
            key: _pageKey,
            child: TaskConfirmationPage(
              key: _scaffoldKey,
              taskId: taskId,
              action: TaskAction.fromString(
                state.uri.queryParameters['action'],
              ),
            ),
          );
        }),
    // Job Screen
    GoRoute(
      path: RoutesName.job,
      redirect: _isLoggedIn,
      pageBuilder: (context, state) {
        final idStr = state.pathParameters["id"];
        final int? jobId = idStr != null ? int.tryParse(idStr) : null;
        if (jobId != null) {
          return MaterialPage<void>(
            key: _pageKey,
            child: HomePage(
              key: _scaffoldKey,
              currentIndex: homeDestinations
                  .indexWhere((element) => element.route == RoutesName.initial),
              child: JobPage(
                jobId: jobId,
              ),
            ),
          );
        }

        return MaterialPage(
          key: _pageKey,
          child: HomePage(
            key: _scaffoldKey,
            currentIndex: homeDestinations
                .indexWhere((element) => element.route == RoutesName.initial),
            child: const Text("Not found"),
          ),
        );
      },
    ),
    // Catalog Screen
    GoRoute(
      path: RoutesName.catalog,
      redirect: _isLoggedIn,
      pageBuilder: (context, state) {
        final idStr = state.pathParameters["id"];
        final int? supplierId = idStr != null ? int.tryParse(idStr) : null;
        if (supplierId != null) {
          return MaterialPage<void>(
            key: _pageKey,
            child: HomePage(
              key: _scaffoldKey,
              currentIndex: homeDestinations.indexWhere(
                  (element) => element.route == RoutesName.catalogs),
              child: CatalogPage(
                supplierId: supplierId,
              ),
            ),
          );
        }

        return MaterialPage(
          key: _pageKey,
          child: HomePage(
            key: _scaffoldKey,
            currentIndex: homeDestinations
                .indexWhere((element) => element.route == RoutesName.contacts),
            child: const Text("Not found"),
          ),
        );
      },
    ),
  ],
);

FutureOr<String?> _isLoggedIn(BuildContext context, state) async {
  LoginCubit loginCubit = context.read<LoginCubit>();
  if (await loginCubit.isLogged()) {
    return null;
  }

  return RoutesName.login;
}
