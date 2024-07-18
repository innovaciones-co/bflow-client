import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class FailureWidget extends StatelessWidget {
  final Failure failure;
  final Color? textColor;
  const FailureWidget({super.key, required this.failure, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        failure.message ?? '',
        style: context.bodyMedium?.copyWith(
          color: textColor ?? AppColor.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
