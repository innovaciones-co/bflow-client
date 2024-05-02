import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/utils/mixins/validator.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/dropdown_widget.dart';
import 'package:bflow_client/src/core/widgets/input_widget.dart';
import 'package:flutter/material.dart';

const List<String> list = [
  'One',
  'Two',
  'Three',
  'Four',
]; // TODO: Delete when DropDown completed

class WriteProductWidget extends StatelessWidget with Validator {
  //final Product? product;
  final String? product;

  WriteProductWidget({super.key, this.product});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      //autovalidateMode: state.autovalidateMode,
      child: ListView(
        children: [
          /* state.formStatus == FormStatus.failed && state.failure != null
              ? Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(10),
                  color: AppColor.red,
                  child: FailureWidget(
                    failure: state.failure!,
                    textColor: Colors.white,
                  ),
                )
              : const SizedBox.shrink(), */
          DropdownWidget<String>(
            label: "Category name",
            items: list,
            getLabel: (s) => s,
            onChanged: null,
            initialValue: list.first,
          ),
          const SizedBox(height: 20),
          InputWidget(
            label: "Sku",
            validator: validateName,
            keyboardType: TextInputType.text,
            initialValue: "",
            onChanged: null,
          ),
          const SizedBox(height: 20),
          InputWidget(
            label: "Prduct name",
            validator: validateName,
            keyboardType: TextInputType.text,
            initialValue: "",
            onChanged: null,
          ),
          const SizedBox(height: 20),
          InputWidget(
            label: "Description",
            validator: validateName,
            keyboardType: TextInputType.text,
            initialValue: "",
            onChanged: null,
          ),
          const SizedBox(height: 20),
          DropdownWidget<String>(
            label: "Measure",
            items: list,
            getLabel: (s) => s,
            onChanged: null,
            initialValue: list.first,
          ),
          const SizedBox(height: 20),
          InputWidget(
            label: "Rate",
            validator: validateName,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            initialValue: "",
            onChanged: null,
          ),
          const SizedBox(height: 20),
          InputWidget(
            label: "Url",
            validator: validateName,
            keyboardType: TextInputType.url,
            initialValue: "",
            onChanged: null,
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
                      onPressed: () {}, //_createProduct(context, productCubit),
                      //inProgress: state.formStatus == FormStatus.inProgress,
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
  }

  /* _createProduct(BuildContext context, WriteProductCubit productCubit) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<WriteProductCubit>(context).createProduct();
    } else {
      productCubit.updateAutovalidateMode(AutovalidateMode.always);
    }
  }

  _updateProduct(BuildContext context, WriteProductCubit productCubit) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<WriteProductCubit>(context).updateProduct();
    } else {
      productCubit.updateAutovalidateMode(AutovalidateMode.always);
    }
  } */
}
