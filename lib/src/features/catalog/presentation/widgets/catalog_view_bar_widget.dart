import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/confirmation_widget.dart';
import 'package:bflow_client/src/features/catalog/presentation/cubit/products_cubit.dart';
import 'package:bflow_client/src/features/catalog/presentation/cubit/upsert_products_cubit/upsert_products_cubit.dart';
import 'package:bflow_client/src/features/catalog/presentation/widgets/import_products_file_widget.dart';
import 'package:bflow_client/src/features/catalog/presentation/widgets/write_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CatalogViewBarWidget extends StatelessWidget {
  final int supplierId;
  final ProductsCubit productsCubit;

  const CatalogViewBarWidget({
    super.key,
    required this.supplierId,
    required this.productsCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        context.isTablet
            ? const SizedBox.shrink()
            : Row(
                children: [
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 500,
                    ),
                    child: TextField(
                      onChanged: null,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide:
                              BorderSide(color: AppColor.grey, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide:
                              BorderSide(color: AppColor.grey, width: 1.5),
                        ),
                        contentPadding:
                            const EdgeInsets.only(top: 0, bottom: 0, right: 10),
                        isDense: true,
                        filled: true,
                        fillColor: AppColor.white,
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search",
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 25,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    color: AppColor.grey,
                  ),
                ],
              ),
        Row(
          children: [
            ActionButtonWidget(
              onPressed: () {
                context.showCustomModal(
                  ConfirmationWidget(
                    title: "Delete products",
                    description:
                        "Are you sure you want to delete the selected product(s)?",
                    onConfirm: () {
                      context.read<ProductsCubit>().deleteProducts();
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
              onPressed: () => context.showLeftDialog(
                "New Product",
                WriteProductWidget(
                  productCubit: context.read(),
                  supplierId: supplierId,
                ),
              ),
              type: ButtonType.elevatedButton,
              title: "New Product",
              icon: Icons.add,
              backgroundColor: AppColor.lightBlue,
            ),
            const SizedBox(width: 12),
            ActionButtonWidget(
              onPressed: () => context.showModal(
                "Import data",
                [
                  BlocProvider<UpsertProductsCubit>(
                    create: (context) => DependencyInjection.sl(),
                    child:
                        BlocConsumer<UpsertProductsCubit, UpsertProductsState>(
                      listener: (context, state) {
                        if (state is UpsertProductsLoadSuccess) {
                          context.pop();
                          context.showAlert(
                              message: state.message, type: AlertType.success);
                          productsCubit.loadSupplierProducts(supplierId);
                        }
                      },
                      builder: (context, state) {
                        return ImportProductsFileWidget(
                          supplierId: supplierId,
                          upsertProductsCubit:
                              context.read<UpsertProductsCubit>(),
                        );
                      },
                    ),
                  ),
                ],
              ),
              type: ButtonType.elevatedButton,
              title: "Import",
              icon: Icons.upload,
              backgroundColor: AppColor.blue,
              foregroundColor: AppColor.white,
            ),
          ],
        ),
      ],
    );
  }
}
