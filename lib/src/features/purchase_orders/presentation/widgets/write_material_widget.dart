import 'package:bflow_client/src/core/config/injection.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/domain/entities/form_status.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/extensions/format_extensions.dart';
import 'package:bflow_client/src/core/utils/mixins/validator.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/dropdown_widget.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/core/widgets/input_widget.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/category_entity.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/product_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/presentation/bloc/items_bloc.dart';
import 'package:bflow_client/src/features/purchase_orders/presentation/bloc/write_item/write_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WriteMaterialWidget extends StatelessWidget with Validator {
  final _formKey = GlobalKey<FormState>();
  final ItemsBloc itemsBloc;
  final int jobId;
  WriteMaterialWidget({
    super.key,
    required this.itemsBloc,
    required this.jobId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WriteItemCubit(
        itemsBloc: itemsBloc,
        jobId: jobId,
        createItemUseCase: DependencyInjection.sl(),
        getSuppliersUseCase: DependencyInjection.sl(),
        getCategoriesBySupplierUseCase: DependencyInjection.sl(),
        getProductsUseCase: DependencyInjection.sl(),
        getItemsUseCase: DependencyInjection.sl(),
      )..initForm(),
      child: BlocConsumer<WriteItemCubit, WriteItemState>(
        listener: (context, state) {
          if (state.formStatus == FormStatus.success) {
            context.showAlert(
              message: "The item was added successfully",
              type: AlertType.success,
            );

            if (context.canPop()) {
              context.pop();
            }
          }
        },
        builder: (context, state) {
          WriteItemCubit writeItemCubit = context.read();

          return Form(
            key: _formKey,
            autovalidateMode: state.autovalidateMode,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                state.formStatus == FormStatus.failed && state.failure != null
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(10),
                        color: AppColor.red,
                        child: FailureWidget(
                          failure: state.failure!,
                          textColor: Colors.white,
                        ),
                      )
                    : const SizedBox.shrink(),
                DropdownWidget<Contact?>(
                  label: "Supplier",
                  items: state.suppliers,
                  getLabel: (s) => s?.name ?? "No contact",
                  onChanged: writeItemCubit.updateSupplier,
                  initialValue: state.supplier,
                  validator: state.autovalidateMode == AutovalidateMode.disabled
                      ? null
                      : validateRequired,
                ),
                const SizedBox(height: 20),
                DropdownWidget<Category?>(
                  label: "Category",
                  items: state.categories,
                  getLabel: (category) => category?.name ?? "",
                  onChanged: writeItemCubit.updateCategory,
                  initialValue: state.category,
                  validator: state.autovalidateMode == AutovalidateMode.disabled
                      ? null
                      : validateRequired,
                ),
                const SizedBox(height: 20),
                DropdownWidget<Product>(
                  label: "Material",
                  items: state.items,
                  getLabel: (s) =>
                      "${s.name} (${s.unitPrice.toCurrency()}/${s.unitOfMeasure.abbreviation})",
                  onChanged: writeItemCubit.updateProduct,
                  initialValue: state.product,
                  validator: state.autovalidateMode == AutovalidateMode.disabled
                      ? null
                      : validateRequired,
                ),
                const SizedBox(height: 20),
                InputWidget(
                  label: "Quantity",
                  onChanged: writeItemCubit.updateQuantity,
                  initialValue: state.quantity.toString(),
                  validator: validateQuantity,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ActionButtonWidget(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      type: ButtonType.textButton,
                      title: "Cancel",
                      paddingHorizontal: 15,
                      paddingVertical: 18,
                    ),
                    const SizedBox(width: 12),
                    ActionButtonWidget(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          writeItemCubit.addItem();
                        } else {
                          writeItemCubit
                              .updateAutovalidateMode(AutovalidateMode.always);
                        }
                      },
                      type: ButtonType.elevatedButton,
                      title: "Create Material",
                      backgroundColor: AppColor.blue,
                      foregroundColor: AppColor.white,
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
