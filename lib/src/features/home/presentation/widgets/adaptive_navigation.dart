import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:bflow_client/src/features/home/presentation/widgets/logo_widget.dart';
import 'package:flutter/material.dart';

class AdaptiveNavigation extends StatefulWidget {
  const AdaptiveNavigation({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.child,
  });

  final List<NavigationDestination> destinations;
  final int selectedIndex;
  final void Function(int index) onDestinationSelected;
  final Widget child;

  @override
  State<AdaptiveNavigation> createState() => _AdaptiveNavigationState();
}

class _AdaptiveNavigationState extends State<AdaptiveNavigation> {
  bool isExtended = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, dimens) {
        if (context.isTablet || context.isDesktop) {
          return Scaffold(
            appBar: const AppBarWidget(),
            body: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NavigationRail(
                  extended: context.isDesktop ? isExtended : false,
                  minExtendedWidth: 180,
                  leading: context.isDesktop
                      ? IconButton(
                          onPressed: _toggleExtended,
                          icon: Icon(
                              isExtended ? Icons.toggle_on : Icons.toggle_off),
                        )
                      : const SizedBox.shrink(),
                  destinations: widget.destinations
                      .map((e) => NavigationRailDestination(
                            icon: e.icon,
                            label: Text(e.label),
                          ))
                      .toList(),
                  selectedIndex: widget.selectedIndex,
                  onDestinationSelected: widget.onDestinationSelected,
                  elevation: 30.0,
                  labelType: isExtended
                      ? context.isDesktop
                          ? null
                          : NavigationRailLabelType.all
                      : NavigationRailLabelType.all,
                ),
                Expanded(child: widget.child),
              ],
            ),
          );
        }
        // Mobile Layout
        return Scaffold(
          drawer: Drawer(
            child: Column(
              children: [
                Container(
                  color: AppColor.black,
                  padding: const EdgeInsets.all(10),
                  child: const SafeArea(child: LogoWidget()),
                ),
                Expanded(
                  child: NavigationRail(
                    extended: true,
                    minExtendedWidth: 180,
                    leading: !context.isMobile
                        ? IconButton(
                            onPressed: _toggleExtended,
                            icon: Icon(isExtended
                                ? Icons.toggle_on
                                : Icons.toggle_off),
                          )
                        : const SizedBox.shrink(),
                    destinations: widget.destinations
                        .map((e) => NavigationRailDestination(
                              icon: e.icon,
                              label: Text(e.label),
                            ))
                        .toList(),
                    selectedIndex: widget.selectedIndex,
                    onDestinationSelected: (index) {
                      widget.onDestinationSelected(index);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          appBar: const AppBarWidget(),
          body: widget.child,
          // bottomNavigationBar: NavigationBar(
          //   destinations: widget.destinations,
          //   selectedIndex: widget.selectedIndex,
          //   onDestinationSelected: widget.onDestinationSelected,
          // ),
        );
      },
    );
  }

  void _toggleExtended() => setState(() {
        isExtended = !isExtended;
      });
}
