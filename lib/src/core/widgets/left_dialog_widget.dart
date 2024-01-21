import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class LeftDialogWidget extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget>? actions;
  const LeftDialogWidget(
      {super.key, required this.child, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.4,
        child: Material(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: context.titleLarge,
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                Expanded(child: child),
                actions != null
                    ? Row(
                        children: actions!,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
