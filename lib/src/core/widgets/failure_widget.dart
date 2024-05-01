import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:flutter/material.dart';

class FailureWidget extends StatelessWidget {
  final Failure failure;
  const FailureWidget({super.key, required this.failure});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(failure.message ?? ''),
    );
  }
}
