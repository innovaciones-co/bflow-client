import 'package:bflow_client/src/core/routes/routes.dart';
import 'package:bflow_client/src/features/home/presentation/pages/home_page.dart';
import 'package:bflow_client/src/features/jobs/presentation/pages/jobs_page.dart';
import 'package:bflow_client/src/features/login/presentation/pages/login_page.dart';
import 'package:bflow_client/src/features/users/presentation/pages/users_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const _pageKey = ValueKey('_pageKey');
const _scaffoldKey = ValueKey('_scaffoldKey');

const List<CustomNavigationDestination> homeDestinations = [
  CustomNavigationDestination(
    label: 'Jobs',
    icon: Icon(Icons.work),
    route: RoutesName.initial,
    child: JobsPage(),
  ),
  CustomNavigationDestination(
    label: 'Users',
    icon: Icon(Icons.people_alt),
    route: RoutesName.users,
    child: UsersPage(),
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
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: _pageKey,
        child: LoginPage(
          key: _scaffoldKey,
        ),
      ),
    ),
  ],
);