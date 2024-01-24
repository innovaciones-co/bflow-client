import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/config.dart';
import '../widgets/adaptive_navigation.dart';
import '../../../../core/routes/router.dart' as router;
import 'package:go_router/go_router.dart' as go;

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.child, required this.currentIndex});

  final Widget child;
  final int currentIndex;
  static const _switcherKey = ValueKey('switcherKey');
  static const _navigationRailKey = ValueKey('navigationRailKey');

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is AlertMessage) {
          context.showAlert(
            message: state.message,
            type: state.type,
          );
        }
      },
      child: LayoutBuilder(
        builder: (context, dimens) {
          void onSelected(int index) {
            final destination = router.homeDestinations[index];
            go.GoRouter.of(context).go(destination.route);
          }

          return AdaptiveNavigation(
            key: _navigationRailKey,
            destinations: router.homeDestinations
                .map((e) => NavigationDestination(
                      icon: e.icon,
                      label: e.label,
                    ))
                .toList(),
            selectedIndex: currentIndex,
            onDestinationSelected: onSelected,
            child: _Switcher(
              key: _switcherKey,
              child: child,
            ),
          );
        },
      ),
    );
  }
}

class _Switcher extends StatelessWidget {
  final Widget child;

  const _Switcher({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      key: key,
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      child: child,
    );
  }
}
