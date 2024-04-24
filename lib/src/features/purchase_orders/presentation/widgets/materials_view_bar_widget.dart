import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:bflow_client/src/features/purchase_orders/presentation/bloc/items_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'write_material_widget.dart';

class MaterialsViewBarWidget extends StatefulWidget {
  const MaterialsViewBarWidget({
    super.key,
  });

  @override
  State<MaterialsViewBarWidget> createState() => _MaterialsViewBarWidgetState();
}

class _MaterialsViewBarWidgetState extends State<MaterialsViewBarWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text("Search"),
            Container(
              width: 1,
              height: 20,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: AppColor.grey,
            ),
          ],
        ),
        Row(
          children: [
            ActionButtonWidget(
              onPressed: () =>
                  context.read<ItemsBloc>().add(DeleteItemsEvent()),
              type: ButtonType.textButton,
              title: "Delete",
              icon: Icons.delete_outline,
              paddingHorizontal: 15,
              paddingVertical: 18,
            ),
            const SizedBox(width: 12),
            ActionButtonWidget(
              onPressed: () => _openWriteMaterialWidget(context),
              type: ButtonType.elevatedButton,
              title: "Add Materials",
              icon: Icons.add,
              backgroundColor: AppColor.lightBlue,
            ),
            const SizedBox(width: 12),
            BlocBuilder<JobBloc, JobState>(
              builder: (context, state) {
                if (state is! JobLoaded) {
                  return const SizedBox.shrink();
                }

                var jobId = state.job.id!;

                return BlocBuilder<ItemsBloc, ItemsState>(
                  builder: (context, state) {
                    var itemsBloc = context.read<ItemsBloc>();

                    if (state is! ItemsLoaded) {
                      return const SizedBox.shrink();
                    }

                    return ActionButtonWidget(
                      onPressed: state.selectedItems.isEmpty
                          ? null
                          : () => itemsBloc
                              .add(CreatePurchaseOrderEvent(jobId: jobId)),
                      type: ButtonType.elevatedButton,
                      title: "Create purchase order",
                      icon: Icons.monetization_on_outlined,
                      backgroundColor: AppColor.blue,
                      foregroundColor: AppColor.white,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  _openWriteMaterialWidget(BuildContext context) {
    JobBloc jobBloc = context.read();
    JobState state = jobBloc.state;

    if (state is JobLoaded) {
      context.showLeftDialog('New Material',
          WriteMaterialWidget(itemsBloc: context.read(), jobId: state.job.id!));
    }
  }
}
