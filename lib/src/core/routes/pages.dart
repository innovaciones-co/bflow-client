library route_pages;

import 'package:bflow_client/src/core/animation/page_slide_transiton.dart';
import 'package:bflow_client/src/features/login/presentation/pages/pages.dart';
import 'package:flutter/material.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../config/error/error.dart';
import 'routes.dart';

class AppRoute {
  static const initial = RoutesName.initial;
  static Route<dynamic> generate(RouteSettings? settings) {
    switch (settings?.name) {
      case RoutesName.login:
        return PageSlideTramsition(const LoginPage()).build();
      case RoutesName.initial:
        return PageSlideTramsition(const HomePage()).build();

      default:
        // If there is no such named route in the switch statement
        throw const RouteException('Route not found!');
    }
  }
}
