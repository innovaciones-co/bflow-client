import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class LeftDialogWidget extends StatefulWidget {
  final String title;
  final Widget child;
  final List<Widget>? actions;
  const LeftDialogWidget(
      {super.key, required this.child, required this.title, this.actions});

  @override
  State<LeftDialogWidget> createState() => _LeftDialogWidgetState();
}

class _LeftDialogWidgetState extends State<LeftDialogWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.reverse();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: SlideTransition(
        position: _offsetAnimation,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: context.isDesktop
              ? MediaQuery.of(context).size.width * 0.4
              : MediaQuery.of(context).size.width * 0.9,
          child: Material(
            color: AppColor.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.title,
                        style: context.titleLarge,
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Expanded(child: widget.child),
                  widget.actions != null
                      ? Row(
                          children: widget.actions!,
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
