import 'package:bflow_client/src/core/config/injection.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/category_entity.dart';
import 'package:bflow_client/src/features/catalog/presentation/cubit/categories_cubit.dart';
import 'package:bflow_client/src/features/catalog/presentation/widgets/write_category_widget.dart';
import 'package:bflow_client/src/features/shared/presentation/widgets/loading_widget.dart';
import 'package:bflow_client/src/features/shared/presentation/widgets/table_header_widget.dart';
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
      child: SizedBox(
        height: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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

                    return context.isMobile || context.isSmallTablet
                        ? _categoriesViewMobile(categories, context, state)
                        : _categoriesViewDesktop(categories, context, state);
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

  _categoriesViewMobile(
      List<Category> categories, BuildContext context, CategoriesLoaded state) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: categories.length,
          itemBuilder: (_, i) {
            return Card(
              elevation: 0,
              margin: const EdgeInsets.symmetric(vertical: 3),
              color: AppColor.lightBlue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: Tooltip(
                        message: categories[i].name,
                        child: Text(
                          categories[i].name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => context.showLeftDialog(
                          "Edit Category",
                          WriteCategoryWidget(
                            category: state.categories[i],
                            categoriesCubit: context.read(),
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
        ),
        _addButton(context, categories),
      ],
    );
  }

  _addButton(BuildContext context, List<Category> categories) {
    return context.isMobile || context.isSmallTablet
        ? Positioned(
            bottom: 30.0,
            right: 5,
            child: Builder(builder: (context) {
              CategoriesCubit categoriesCubit = context.read();
              return FloatingActionButton(
                onPressed: () => context.showLeftDialog(
                  "New Category",
                  WriteCategoryWidget(
                    categoriesCubit: categoriesCubit,
                  ),
                ),
                backgroundColor: AppColor.blue,
                shape: const CircleBorder(),
                child: const Icon(Icons.add),
              );
            }),
          )
        : const SizedBox.shrink();
  }

  _categoriesViewDesktop(
      List<Category> categories, BuildContext context, CategoriesLoaded state) {
    return SingleChildScrollView(
      child: Table(
        border: TableBorder.all(
          color: AppColor.grey,
        ),
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: AppColor.grey,
            ),
            children: const [
              TableHeaderWidget(label: "Trade code"),
              TableHeaderWidget(label: "Name"),
              TableHeaderWidget(label: "Actions"),
            ],
          ),
          ...categories.map(
            (e) => TableRow(
              decoration: BoxDecoration(
                color: AppColor.white,
              ),
              children: [
                _tableData(context, e.tradeCode.toString()),
                _tableData(context, e.name),
                _tableActions(context, e),
              ],
            ),
          )
        ],
      ),
    );
  }

  _tableData(BuildContext context, String label) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Text(label, style: context.bodyMedium),
      ),
    );
  }

  _tableActions(BuildContext context, Category category) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => context.showLeftDialog(
                "Edit Category",
                WriteCategoryWidget(
                  category: category,
                  categoriesCubit: context.read(),
                ),
              ),
              color: AppColor.blue,
              icon: const Icon(Icons.edit_outlined),
              tooltip: 'Edit',
            ),
            Builder(builder: (context) {
              return IconButton(
                onPressed: () => context
                    .read<CategoriesCubit>()
                    .deleteCategory(category.id!),
                color: AppColor.blue,
                icon: const Icon(
                  Icons.delete_outline_outlined,
                  size: 20,
                ),
                tooltip: 'Delete',
              );
            }),
          ],
        ),
      ),
    );
  }
}
