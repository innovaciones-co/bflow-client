import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:flutter/material.dart';

import 'write_materials_widget.dart';

class NoMaterialsWidget extends StatelessWidget {
  const NoMaterialsWidget({
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
              "No materials yet",
              style: context.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionButtonWidget(
                  onPressed: () => context.showLeftDialog(
                      'Import Materials', const WriteMaterialsWidget()),
                  type: ButtonType.textButton,
                  title: "Add materials from template",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
