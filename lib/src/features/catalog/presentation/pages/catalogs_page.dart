import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/routes/routes.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/core/widgets/page_container_widget.dart';
import 'package:bflow_client/src/features/catalog/presentation/cubit/categories_cubit.dart';
import 'package:bflow_client/src/features/catalog/presentation/widgets/categories_widget.dart';
import 'package:bflow_client/src/features/catalog/presentation/widgets/write_category_widget.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_type.dart';
import 'package:bflow_client/src/features/contacts/presentation/cubit/contacts_cubit.dart';
import 'package:bflow_client/src/features/shared/presentation/widgets/loading_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CatalogsPage extends StatefulWidget {
  const CatalogsPage({super.key});

  @override
  State<CatalogsPage> createState() => _CatalogsPageState();
}

class _CatalogsPageState extends State<CatalogsPage>
    with TickerProviderStateMixin {
  late TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();

    tabController!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ContactsCubit>(
          create: (context) =>
              DependencyInjection.sl()..loadContacts(ContactType.supplier),
        ),
        BlocProvider<CategoriesCubit>(
          create: (context) => DependencyInjection.sl()..loadCategories(),
        ),
      ],
      child: Builder(builder: (myContext) {
        return PageContainerWidget(
          title: 'Catalogs',
          actions: tabController?.index == 0
              ? null
              : [
                  !(context.isMobile || context.isSmallTablet)
                      ? ActionButtonWidget(
                          onPressed: () => myContext.showLeftDialog(
                            "New Category",
                            WriteCategoryWidget(
                              categoriesCubit: myContext.read(),
                            ),
                          ),
                          type: ButtonType.elevatedButton,
                          title: "New Category",
                          backgroundColor: AppColor.blue,
                          foregroundColor: AppColor.white,
                          icon: Icons.add,
                        )
                      : const SizedBox.shrink(),
                ],
          child: BlocBuilder<ContactsCubit, ContactsState>(
            builder: (context, state) {
              if (state is ContactsLoading) {
                return const LoadingWidget();
              }

              if (state is ContactsError) {
                return FailureWidget(failure: state.failure);
              }

              var suppliers = (state as ContactsLoaded).contacts;

              return Column(
                children: [
                  TabBar(
                    controller: tabController,
                    tabs: const [
                      Tab(text: "Supplier"),
                      Tab(text: "Categories"),
                    ],
                    labelColor: AppColor.blue,
                    indicatorColor: AppColor.blue,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 3,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        _catalogsGrid(context, suppliers),
                        const CategoriesWidget(),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        );
      }),
    );
  }

  GridView _catalogsGrid(BuildContext context, List<Contact> suppliers) {
    return GridView.count(
      crossAxisCount:
          context.isMobile || context.isSmallTablet || context.isSmall
              ? 2
              : context.isLargeDesktop
                  ? 4
                  : 3,
      childAspectRatio: context.isMobile || context.isSmallTablet
          ? 2
          : context.isLargeDesktop
              ? 3
              : 2.2,
      children: suppliers
          .mapIndexed(
              (index, supplier) => _supplierItem(index, supplier, context))
          .toList(),
    );
  }

  Widget _supplierItem(int index, Contact supplier, BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _goToDetails(context, supplier.id!),
        child: Card(
          elevation: 0,
          color:
              AppColor.todoColors.elementAt(index % AppColor.todoColors.length),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  supplier.name,
                  style: context.headlineSmall,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  'Catalog',
                  style: context.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _goToDetails(BuildContext context, int supplierId) {
    context.go(RoutesName.catalog.replaceAll(":id", supplierId.toString()));
  }
}
