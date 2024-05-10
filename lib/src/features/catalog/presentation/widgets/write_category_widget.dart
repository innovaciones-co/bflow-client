import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/utils/mixins/validator.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/input_widget.dart';
import 'package:flutter/material.dart';

class WriteCategorytWidget extends StatelessWidget with Validator {
  final String? category;

  WriteCategorytWidget({super.key, this.category});

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
          InputWidget(
            label: "Trade code",
            validator: validateName,
            keyboardType: TextInputType.text,
            initialValue: "",
            onChanged: null,
          ),
          const SizedBox(height: 20),
          InputWidget(
            label: "Category name",
            validator: validateName,
            keyboardType: TextInputType.text,
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
              category == null
                  ? ActionButtonWidget(
                      onPressed:
                          () {}, //_createCategory(context, categoryCubit),
                      //inProgress: state.formStatus == FormStatus.inProgress,
                      type: ButtonType.elevatedButton,
                      title: "Create Category",
                      backgroundColor: AppColor.blue,
                      foregroundColor: AppColor.white,
                    )
                  : ActionButtonWidget(
                      onPressed:
                          () {}, // _updateCategory(context, categoryCubit),
                      //inProgress: state.formStatus == FormStatus.inProgress,
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
  }

  /* _createCategory(BuildContext context, WriteCategoryCubit categoryCubit) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<WriteCategoryCubit>(context).createCategory();
    } else {
      categoryCubit.updateAutovalidateMode(AutovalidateMode.always);
    }
  }

  _updateCategory(BuildContext context, WriteCategoryCubit categoryCubit) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<WriteCategoryCubit>(context).updateCategory();
    } else {
      categoryCubit.updateAutovalidateMode(AutovalidateMode.always);
    }
  } */
}
