import 'package:bflow_client/src/features/jobs/domain/entities/template_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';

abstract class TemplateRepository {
  Future<Either<Failure, List<TemplateEntity>>> getTemplates();

  Future<Either<Failure, void>> createTasksFromTemplate(
      int templateId, int jobId);
}
