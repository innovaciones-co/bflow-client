import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/dropdown_widget.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/template_entity.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/templates/templates_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NoTasksWidget extends StatelessWidget {
  final int jobId;
  final TasksBloc tasksBloc;
  const NoTasksWidget({
    super.key,
    required this.jobId,
    required this.tasksBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.lightGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/img/no_data_found.png',
          ),
          const SizedBox(height: 15),
          Text(
            "No activities yet",
            style: context.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text("Add a new activity"),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActionButtonWidget(
                onPressed: () {
                  _createActivityFromTemplate(context);
                },
                type: ButtonType.textButton,
                title: "Create from template",
              ),
            ],
          )
        ],
      ),
    );
  }

  _createActivityFromTemplate(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider<TemplatesCubit>(
          create: (context) => TemplatesCubit(
            createTasksFromTemplateUseCase: DependencyInjection.sl(),
            templatesUseCase: DependencyInjection.sl(),
            tasksBloc: tasksBloc,
          )..loadTemplates(),
          child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: context.isDesktop
                    ? context.width * 0.3
                    : context.width * 0.8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColor.white,
              ),
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add new activities",
                    style: context.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  BlocBuilder<TemplatesCubit, TemplatesState>(
                    builder: (context, state) {
                      TemplatesCubit templateCubit =
                          context.read<TemplatesCubit>();

                      if (state is TemplatesError) {
                        return FailureWidget(failure: state.failure);
                      }

                      if (state is TemplatesLoaded) {
                        return DropdownWidget<TemplateEntity>(
                          label:
                              "Choose the template you want to use to create the activities:",
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
                                    templateCubit
                                        .createTasksFromTemplate(jobId);
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
            ),
          ),
        );
      },
    );
  }
}
