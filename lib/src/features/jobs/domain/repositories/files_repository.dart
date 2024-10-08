import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/jobs/data/models/file_model.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/file_entity.dart';
import 'package:dartz/dartz.dart';

abstract class FilesRepository {
  Future<Either<Failure, FileModel>> upload(File file);

  Future<Either<Failure, void>> delete(int id);
}
