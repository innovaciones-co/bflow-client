import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/template_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/template_type.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/create_tasks_from_template_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/get_templates_use_case.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'templates_state.dart';

class TemplatesCubit extends Cubit<TemplatesState> {
  final CreateTasksFromTemplateUseCase createFromTemplateUseCase;
  final GetTemplatesUseCase templatesUseCase;
  final TasksBloc tasksBloc;

  TemplatesCubit({
    required this.createFromTemplateUseCase,
    required this.templatesUseCase,
    required this.tasksBloc,
  }) : super(TemplatesInitial());

  void loadTemplates(TemplateType templateType) async {
    var response = await templatesUseCase.execute(templateType);

    response.fold(
      (failure) => emit(TemplatesError(failure: failure)),
      (templates) => emit(TemplatesLoaded(templates: templates)),
    );
  }

  void changeSelectedTemplate(TemplateEntity template) {
    if (state is TemplatesLoaded) {
      var state = (this.state as TemplatesLoaded);
      emit(state.copyWith(selectedTemplate: template));
    }
  }

  void createFromTemplate(int jobId) async {
    if (state is TemplatesLoaded) {
      var state = (this.state as TemplatesLoaded);
      var params = CreateFromTemplateParams(
          templateId: state.selectedTemplate.id, jobId: jobId);
      emit(TemplatesInitial());
      tasksBloc.add(LoadingTasksEvent());
      await createFromTemplateUseCase.execute(params);
      tasksBloc.add(GetTasksEvent(jobId: jobId));
    }
  }
}
