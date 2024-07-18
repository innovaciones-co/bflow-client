import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:flutter/material.dart';

class FooterBarWidget extends StatefulWidget {
  final Widget? leading;
  final List<Widget> actions;
  final Function()? onCancel;

  const FooterBarWidget({
    super.key,
    this.leading,
    required this.actions,
    this.onCancel,
  });

  @override
  State<FooterBarWidget> createState() => _FooterBarWidgetState();
}

class _FooterBarWidgetState extends State<FooterBarWidget>
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
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
        height: 80,
        width: double.maxFinite - 20,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, -3),
              blurRadius: 3,
              spreadRadius: -1,
            ),
            BoxShadow(
              color: Colors.transparent,
              offset: Offset.zero,
            ),
            BoxShadow(
              color: Colors.transparent,
              offset: Offset.zero,
            ),
            BoxShadow(
              color: Colors.transparent,
              offset: Offset.zero,
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.leading ?? const SizedBox.shrink(),
              const Spacer(),
              ActionButtonWidget(
                onPressed: () {
                  _controller.reverse();
                  if (widget.onCancel != null) {
                    widget.onCancel!();
                  }
                },
                title: 'Cancel',
                type: ButtonType.textButton,
              ),
              const SizedBox(
                width: 10,
              ),
              ...widget.actions
            ],
          ),
        ),
      ),
    );
  }
}
