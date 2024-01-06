import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

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
    //final bloc = BlocProvider.of<HomeBloc>(context);
    return LayoutBuilder(
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
          child: Expanded(
            child: _Switcher(
              key: _switcherKey,
              child: child,
            ),
          ),
        );
      },
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
