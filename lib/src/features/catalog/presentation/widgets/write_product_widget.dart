import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/domain/entities/form_status.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/utils/mixins/validator.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/dropdown_widget.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/core/widgets/input_widget.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/product_entity.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/units.dart';
import 'package:bflow_client/src/features/catalog/presentation/cubit/products_cubit.dart';
import 'package:bflow_client/src/features/catalog/presentation/cubit/write_product_cubit/write_product_cubit.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WriteProductWidget extends StatelessWidget with Validator {
  final _formKey = GlobalKey<FormState>();
  final Product? product;
  final ProductsCubit productCubit;
  final int supplierId;

  WriteProductWidget({
    super.key,
    this.product,
    required this.productCubit,
    required this.supplierId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WriteProductCubit(
        productsCubit: productCubit,
        createProductUseCase: DependencyInjection.sl(),
        getCategoriesUseCase: DependencyInjection.sl(),
      )..initForm(supplier: supplierId),
      child: BlocConsumer<WriteProductCubit, WriteProductState>(
        listener: (context, state) {
          if (state.formStatus == FormStatus.success) {
            context.showAlert(
              message: "The product was added successfully!",
              type: AlertType.success,
            );

            if (context.canPop()) {
              context.pop();
            }
          }
        },
        builder: (context, state) {
          WriteProductCubit writeProductCubit = context.read();

          if (state.formStatus != FormStatus.loaded) {
            return const Center(child: CircularProgressIndicator());
          }

          return Form(
            key: _formKey,
            autovalidateMode: state.autovalidateMode,
            child: ListView(
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
                DropdownWidget<Category?>(
                  label: "Category name",
                  items: state.categories,
                  getLabel: (category) => category?.name ?? '',
                  onChanged: writeProductCubit.updateCategory,
                  initialValue: state.categories
                      .where((cat) => cat.id == state.category)
                      .firstOrNull,
                  validator: state.autovalidateMode == AutovalidateMode.disabled
                      ? null
                      : validateRequired,
                ),
                const SizedBox(height: 20),
                InputWidget(
                  label: "SKU",
                  validator: validateSku,
                  keyboardType: TextInputType.text,
                  initialValue: "",
                  onChanged: writeProductCubit.updateSku,
                ),
                const SizedBox(height: 20),
                InputWidget(
                  label: "Product name",
                  validator: validateProductName,
                  keyboardType: TextInputType.text,
                  initialValue: "",
                  onChanged: writeProductCubit.updateName,
                ),
                const SizedBox(height: 20),
                InputWidget(
                  label: "Description",
                  validator: validateDescription,
                  keyboardType: TextInputType.text,
                  initialValue: "",
                  onChanged: writeProductCubit.updateDescription,
                ),
                const SizedBox(height: 20),
                DropdownWidget<Unit>(
                  label: "Measure",
                  items: Unit.values,
                  getLabel: (s) => s.toString(),
                  onChanged: writeProductCubit.updateUnitOfMeasure,
                  initialValue: Unit.values.first,
                  validator: state.autovalidateMode == AutovalidateMode.disabled
                      ? null
                      : validateRequired,
                ),
                const SizedBox(height: 20),
                InputWidget(
                  label: "Rate",
                  validator: validateUnitPrice,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  initialValue: "",
                  onChanged: writeProductCubit.updateUnitPrice,
                ),
                const SizedBox(height: 20),
                InputWidget(
                  label: "Url",
                  validator: validateUrl,
                  keyboardType: TextInputType.url,
                  initialValue: "",
                  onChanged: writeProductCubit.updateUrl,
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
                    product == null
                        ? ActionButtonWidget(
                            onPressed: () =>
                                _createProduct(context, writeProductCubit),
                            inProgress:
                                state.formStatus == FormStatus.inProgress,
                            type: ButtonType.elevatedButton,
                            title: "Create Product",
                            backgroundColor: AppColor.blue,
                            foregroundColor: AppColor.white,
                          )
                        : ActionButtonWidget(
                            onPressed:
                                () {}, // _updateProduct(context, productCubit),
                            //inProgress: state.formStatus == FormStatus.inProgress,
                            type: ButtonType.elevatedButton,
                            title: "Save Product",
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

  _createProduct(BuildContext context, WriteProductCubit productCubit) {
    if (_formKey.currentState == null) return;

    if (_formKey.currentState!.validate()) {
      BlocProvider.of<WriteProductCubit>(context).createProduct();
    } else {
      productCubit.updateAutovalidateMode(AutovalidateMode.always);
    }
  }

/*  _updateProduct(BuildContext context, WriteProductCubit productCubit) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<WriteProductCubit>(context).updateProduct();
    } else {
      productCubit.updateAutovalidateMode(AutovalidateMode.always);
    }
  } */
}
