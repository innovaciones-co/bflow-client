import 'package:bflow_client/src/core/config/injection.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/features/catalog/presentation/cubit/categories_cubit.dart';
import 'package:bflow_client/src/features/catalog/presentation/widgets/write_category_widget.dart';
import 'package:bflow_client/src/features/shared/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoriesCubit>(
      create: (context) => DependencyInjection.sl()..loadCategories(),
      child: Container(
        height: double.maxFinite,
        width: 400,
        margin: const EdgeInsets.only(left: 15),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
              color: AppColor.grey,
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Categories", style: context.headlineMedium),
                ActionButtonWidget(
                  onPressed: () => context.showLeftDialog(
                    "New Category",
                    WriteCategoryWidget(),
                  ),
                  type: ButtonType.elevatedButton,
                  title: "New",
                  icon: Icons.add,
                  backgroundColor: AppColor.blue,
                  foregroundColor: AppColor.white,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesLoading ||
                      state is CategoriesInitial) {
                    return const LoadingWidget();
                  }

                  if (state is CategoriesError) {
                    return FailureWidget(failure: state.failure);
                  }

                  if (state is CategoriesLoaded) {
                    var categories = state.categories;

                    return ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (_, i) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 3),
                          color: AppColor.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15,
                                ),
                                child: Text(categories[i].name),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () => context.showLeftDialog(
                                      "Edit Category",
                                      WriteCategoryWidget(
                                        category: state.categories[i],
                                      ),
                                    ),
                                    color: AppColor.blue,
                                    icon: const Icon(
                                      Icons.edit_outlined,
                                      size: 20,
                                    ),
                                    tooltip: 'Edit',
                                  ),
                                  IconButton(
                                    onPressed: () => context
                                        .read<CategoriesCubit>()
                                        .deleteCategory(categories[i].id!),
                                    color: AppColor.blue,
                                    icon: const Icon(
                                      Icons.delete_outline_outlined,
                                      size: 20,
                                    ),
                                    tooltip: 'Delete',
                                  ),
                                  const SizedBox(width: 15)
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
