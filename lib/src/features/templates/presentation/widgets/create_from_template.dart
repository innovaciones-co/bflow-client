import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/dialog_widget.dart';
import 'package:bflow_client/src/core/widgets/dropdown_widget.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/features/templates/domain/entities/template_entity.dart';
import 'package:bflow_client/src/features/templates/domain/entities/template_type.dart';
import 'package:bflow_client/src/features/templates/presentation/cubit/templates_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

createFromTemplate({
  required BuildContext context,
  required int jobId,
  TemplateType type = TemplateType.task,
  Function? onLoading,
  Function? onCreated,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocProvider<TemplatesCubit>(
        create: (context) => TemplatesCubit(
          createFromTemplateUseCase: DependencyInjection.sl(),
          templatesUseCase: DependencyInjection.sl(),
          onLoading: onLoading,
          onCreated: onCreated,
        )..loadTemplates(type),
        child: DialogWidget(
          title: "Add ${type.pluralName} from template",
          children: [
            BlocBuilder<TemplatesCubit, TemplatesState>(
              builder: (context, state) {
                TemplatesCubit templateCubit = context.read<TemplatesCubit>();

                if (state is TemplatesError) {
                  return FailureWidget(failure: state.failure);
                }

                if (state is TemplatesLoaded) {
                  return DropdownWidget<TemplateEntity>(
                    label:
                        "Choose the template you want to use to create the ${type.pluralName}:",
                    labelPadding: const EdgeInsets.all(0),
                    items: state.templates,
                    getLabel: (template) => template.name,
                    onChanged: templateCubit.changeSelectedTemplate,
                    initialValue: state.templates.first,
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
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
                BlocBuilder<TemplatesCubit, TemplatesState>(
                  builder: (context, state) {
                    TemplatesCubit templateCubit =
                        context.read<TemplatesCubit>();

                    return ActionButtonWidget(
                      onPressed: state is TemplatesLoaded
                          ? () {
                              templateCubit.createFromTemplate(jobId);
                              context.pop();
                            }
                          : null,
                      type: ButtonType.elevatedButton,
                      title: "Create",
                      backgroundColor: AppColor.blue,
                      foregroundColor: AppColor.white,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
