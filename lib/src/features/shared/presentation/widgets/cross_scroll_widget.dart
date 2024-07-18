import 'package:flutter/material.dart';

class CrossScrollWidget extends StatelessWidget {
  final Widget child;

  CrossScrollWidget({super.key, required this.child});

  final ScrollController _scrollControllerHorizontal = ScrollController();
  final ScrollController _scrollControllerVertical = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      trackVisibility: true,
      controller: _scrollControllerVertical,
      child: SingleChildScrollView(
        controller: _scrollControllerVertical,
        scrollDirection: Axis.vertical,
        child: Scrollbar(
          thumbVisibility: true,
          trackVisibility: true,
          controller: _scrollControllerHorizontal,
          child: SingleChildScrollView(
            controller: _scrollControllerHorizontal,
            scrollDirection: Axis.horizontal,
            child: child,
          ),
        ),
      ),
    );
  }
}
