import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/template_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/template_repository.dart';
import 'package:dartz/dartz.dart';

class GetTemplatesUseCase implements UseCase<List<TemplateEntity>, NoParams> {
  final TemplateRepository templateRepository;

  GetTemplatesUseCase({required this.templateRepository});

  @override
  Future<Either<Failure, List<TemplateEntity>>> execute(NoParams params) {
    return templateRepository.getTemplates();
  }
}
