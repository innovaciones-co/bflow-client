import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/template_repository.dart';
import 'package:dartz/dartz.dart';

class CreateTasksFromTemplateUseCase
    implements UseCase<void, CreateFromTemplateParams> {
  final TemplateRepository templateRepository;

  CreateTasksFromTemplateUseCase({required this.templateRepository});

  @override
  Future<Either<Failure, void>> execute(CreateFromTemplateParams params) {
    return templateRepository.createTasksFromTemplate(
        params.templateId, params.jobId);
  }
}

class CreateFromTemplateParams {
  final int templateId;
  final int jobId;

  CreateFromTemplateParams({required this.templateId, required this.jobId});
}
