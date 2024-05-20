import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/domain/entities/form_status.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/utils/mixins/validator.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/core/widgets/input_widget.dart';
import 'package:bflow_client/src/features/catalog/domain/entities/category_entity.dart';
import 'package:bflow_client/src/features/catalog/presentation/cubit/products_cubit.dart';
import 'package:bflow_client/src/features/catalog/presentation/cubit/write_category_cubit/write_category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WriteCategorytWidget extends StatelessWidget with Validator {
  final ProductsCubit productsCubit;
  final Category? category;

  WriteCategorytWidget({super.key, this.category, required this.productsCubit});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WriteCategoryCubit>(
      create: (context) => WriteCategoryCubit(
        createCategorytUseCase: DependencyInjection.sl(),
        updateCategorytUseCase: DependencyInjection.sl(),
        productsCubit: productsCubit,
      )..initFormFromCategory(category),
      child: BlocConsumer<WriteCategoryCubit, WriteCategoryState>(
        listener: (context, state) {
          if (state.formStatus == FormStatus.success) {
            context.showAlert(
                message: "The category was created successfully!",
                type: AlertType.success);

            if (context.canPop()) {
              context.pop();
            }
          }
        },
        builder: (context, state) {
          WriteCategoryCubit writeCategoryCubit =
              context.read<WriteCategoryCubit>();

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
                InputWidget(
                  label: "Trade code",
                  validator: validateTradeCode,
                  keyboardType: const TextInputType.numberWithOptions(),
                  initialValue:
                      state.tradeCode == null ? '' : state.tradeCode.toString(),
                  onChanged: writeCategoryCubit.updateTradeCode,
                ),
                const SizedBox(height: 20),
                InputWidget(
                  label: "Category name",
                  validator: validateName,
                  keyboardType: TextInputType.text,
                  initialValue: state.name,
                  onChanged: writeCategoryCubit.updateName,
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
                    category == null
                        ? ActionButtonWidget(
                            onPressed: () =>
                                _createCategory(context, writeCategoryCubit),
                            inProgress:
                                state.formStatus == FormStatus.inProgress,
                            type: ButtonType.elevatedButton,
                            title: "Create Category",
                            backgroundColor: AppColor.blue,
                            foregroundColor: AppColor.white,
                          )
                        : ActionButtonWidget(
                            onPressed: () =>
                                _updateCategory(context, writeCategoryCubit),
                            inProgress:
                                state.formStatus == FormStatus.inProgress,
                            type: ButtonType.elevatedButton,
                            title: "Save Category",
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

  _createCategory(BuildContext context, WriteCategoryCubit writeCategoryCubit) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<WriteCategoryCubit>(context).createCategory();
    } else {
      writeCategoryCubit.updateAutovalidateMode(AutovalidateMode.always);
    }
  }

  _updateCategory(BuildContext context, WriteCategoryCubit writeCategoryCubit) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<WriteCategoryCubit>(context).updateCategory();
    } else {
      writeCategoryCubit.updateAutovalidateMode(AutovalidateMode.always);
    }
  }
}
