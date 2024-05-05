import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/features/templates/domain/entities/template_type.dart';
import 'package:bflow_client/src/features/purchase_orders/presentation/bloc/items_bloc.dart';
import 'package:bflow_client/src/features/templates/presentation/widgets/create_from_template.dart';
import 'package:flutter/material.dart';

class NoMaterialsWidget extends StatelessWidget {
  final int jobId;
  final ItemsBloc itemsBloc;

  const NoMaterialsWidget({
    super.key,
    required this.jobId,
    required this.itemsBloc,
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
                  onPressed: () {
                    createFromTemplate(
                      context: context,
                      jobId: jobId,
                      onLoading: _loadingItems,
                      onCreated: _loadItems,
                      type: TemplateType.material,
                    );
                  },
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

  _loadItems() {
    itemsBloc.add(GetItemsEvent(jobId: jobId));
  }

  _loadingItems() {
    itemsBloc.add(LoadingItemsEvent());
  }
}
