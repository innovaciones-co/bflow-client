import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/routes/routes.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/core/widgets/page_container_widget.dart';
import 'package:bflow_client/src/features/catalog/presentation/widgets/categories_widget.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_type.dart';
import 'package:bflow_client/src/features/contacts/presentation/cubit/contacts_cubit.dart';
import 'package:bflow_client/src/features/shared/presentation/widgets/loading_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CatalogsPage extends StatelessWidget {
  const CatalogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainerWidget(
      title: 'Catalogs',
      child: BlocProvider<ContactsCubit>(
        create: (context) =>
            DependencyInjection.sl()..loadContacts(ContactType.supplier),
        child: BlocBuilder<ContactsCubit, ContactsState>(
          builder: (context, state) {
            if (state is ContactsLoading) {
              return const LoadingWidget();
            }

            if (state is ContactsError) {
              return FailureWidget(failure: state.failure);
            }

            var suppliers = (state as ContactsLoaded).contacts;

            return Row(
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: context.isMobile || context.isSmallTablet
                        ? 2
                        : context.isTablet
                            ? 3
                            : 4,
                    childAspectRatio:
                        context.isMobile || context.isTablet ? 2 : 3,
                    children: suppliers
                        .mapIndexed((index, supplier) =>
                            _supplierItem(index, supplier, context))
                        .toList(),
                  ),
                ),
                const CategoriesWidget()
              ],
            );
          },
        ),
      ),
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
