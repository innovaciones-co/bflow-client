library route_pages;

import 'package:flutter/material.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '/src/core/error/error.dart';
import 'routes.dart';

class AppRoute {
  static const initial = RoutesName.initial;
  static Route<dynamic> generate(RouteSettings? settings) {
    switch (settings?.name) {
      case RoutesName.initial:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );

      default:
        // If there is no such named route in the switch statement
        throw const RouteException('Route not found!');
    }
  }
}
