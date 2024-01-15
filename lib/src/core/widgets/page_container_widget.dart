import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class PageContainerWidget extends StatelessWidget {
  const PageContainerWidget({super.key, required this.title, this.child});

  final String title;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/img/background.png',
              height: _getHeight(context),
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: _getPadding(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.displaySmall,
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: child ?? const SizedBox.shrink(),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  EdgeInsets _getPadding(BuildContext context) {
    if (context.isDesktop) {
      return const EdgeInsets.symmetric(horizontal: 60, vertical: 40.0);
    }

    if (context.isTablet) {
      return const EdgeInsets.symmetric(horizontal: 40, vertical: 30.0);
    }

    return const EdgeInsets.symmetric(horizontal: 14, vertical: 20.0);
  }

  double _getHeight(BuildContext context) {
    if (context.isDesktop) {
      return 300;
    }

    if (context.isTablet) {
      return 250;
    }

    return 200;
  }
}
