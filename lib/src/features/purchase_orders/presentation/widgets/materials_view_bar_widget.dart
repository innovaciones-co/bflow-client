import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/confirmation_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job/job_bloc.dart';
import 'package:bflow_client/src/features/purchase_orders/presentation/bloc/items_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        /* Row(
          children: [
            const Text("Search"),
            Container(
              width: 1,
              height: 20,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: AppColor.grey,
            ),
          ],
        ), */
        Row(
          children: [
            if (!(context.isMobile || context.isSmallTablet)) ...[
              BlocBuilder<ItemsBloc, ItemsState>(
                builder: (context, state) {
                  if (state is ItemsLoaded) {
                    var itemModified = (state).itemModified;

                    return itemModified
                        ? Row(
                            children: [
                              ActionButtonWidget(
                                onPressed: () => context
                                    .read<ItemsBloc>()
                                    .add(SaveUpdatedItems()),
                                type: ButtonType.elevatedButton,
                                title: "Save",
                                icon: Icons.save,
                                backgroundColor: AppColor.lightBlue,
                              ),
                              Container(
                                width: 1,
                                height: 20,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                color: AppColor.grey,
                              ),
                            ],
                          )
                        : const SizedBox.shrink();
                  }

                  return const SizedBox.shrink();
                },
              ),
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
                      if (state.selectedItems.isNotEmpty) {
                        return Row(
                          children: [
                            ActionButtonWidget(
                              onPressed: () {
                                context.showCustomModal(
                                  ConfirmationWidget(
                                    title: "Delete materials",
                                    description:
                                        "Are you sure you want to delete the selected material(s)?",
                                    onConfirm: () {
                                      context
                                          .read<ItemsBloc>()
                                          .add(DeleteItemsEvent());
                                      context.pop();
                                    },
                                    confirmText: "Delete",
                                  ),
                                );
                              },
                              type: ButtonType.textButton,
                              title: "Delete",
                              icon: Icons.delete_outline,
                              paddingHorizontal: 15,
                              paddingVertical: 18,
                            ),
                            const SizedBox(width: 12),
                            ActionButtonWidget(
                              onPressed: () => itemsBloc
                                  .add(CreatePurchaseOrderEvent(jobId: jobId)),
                              type: ButtonType.elevatedButton,
                              title: "Create purchase order",
                              icon: Icons.monetization_on_outlined,
                              backgroundColor: AppColor.lightBlue,
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  );
                },
              ),
              const SizedBox(width: 12),
              ActionButtonWidget(
                onPressed: () => _openWriteMaterialWidget(context),
                type: ButtonType.elevatedButton,
                title: "Add Materials",
                icon: Icons.add,
                backgroundColor: AppColor.blue,
                foregroundColor: AppColor.white,
              ),
            ],
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
