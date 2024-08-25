import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/templates/domain/entities/template_entity.dart';
import 'package:bflow_client/src/features/templates/domain/entities/template_type.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/create_tasks_from_template_use_case.dart';
import 'package:bflow_client/src/features/templates/domain/usecases/get_templates_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'templates_state.dart';

class TemplatesCubit extends Cubit<TemplatesState> {
  final CreateTasksFromTemplateUseCase createFromTemplateUseCase;
  final GetTemplatesUseCase templatesUseCase;
  final Function? onLoading;
  final Function? onCreated;

  TemplatesCubit({
    required this.createFromTemplateUseCase,
    required this.templatesUseCase,
    this.onLoading,
    this.onCreated,
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
      if (state.selectedTemplate == null) return;

      var params = CreateFromTemplateParams(
          templateId: state.selectedTemplate!.id, jobId: jobId);
      emit(TemplatesInitial());
      if (onLoading != null) {
        onLoading!();
      }
      await createFromTemplateUseCase.execute(params);
      if (onCreated != null) {
        onCreated!();
      }
    }
  }
}
