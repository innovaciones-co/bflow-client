import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/exceptions/remote_data_source_exception.dart';
import 'package:bflow_client/src/features/jobs/data/sources/template_remote_data_source.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/template_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/template_type.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/template_repository.dart';
import 'package:dartz/dartz.dart';

class TemplatesRepositoryImp implements TemplateRepository {
  final TemplateRemoteDataSource templateRemoteDataSource;

  TemplatesRepositoryImp({required this.templateRemoteDataSource});

  @override
  Future<Either<Failure, void>> createTasksFromTemplate(
      int templateId, int jobId) async {
    try {
      return Right(await templateRemoteDataSource.createTasksFromTemplate(
          templateId, jobId));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<TemplateEntity>>> getTemplates(
      TemplateType templateType) async {
    try {
      var templates =
          await templateRemoteDataSource.fetchTemplates(templateType);
      return Right(templates);
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
