import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class NoProductsWidget extends StatelessWidget {
  const NoProductsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.lightGrey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/no_data_found.png',
            ),
            const SizedBox(height: 15),
            Text(
              "No products yet",
              style: context.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
