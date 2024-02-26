import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/template_repository.dart';
import 'package:dartz/dartz.dart';

class CreateTasksFromTemplateUseCase
    implements UseCase<void, CreateTasksFromTemplateParams> {
  final TemplateRepository templateRepository;

  CreateTasksFromTemplateUseCase({required this.templateRepository});

  @override
  Future<Either<Failure, void>> execute(CreateTasksFromTemplateParams params) {
    return templateRepository.createTasksFromTemplate(
        params.templateId, params.jobId);
  }
}

class CreateTasksFromTemplateParams {
  final int templateId;
  final int jobId;

  CreateTasksFromTemplateParams(
      {required this.templateId, required this.jobId});
}
