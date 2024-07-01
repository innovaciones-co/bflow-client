import 'package:bflow_client/src/core/exceptions/bad_request_exception.dart';
import 'package:bflow_client/src/core/exceptions/bad_response_exception.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/exceptions/remote_data_source_exception.dart';
import 'package:bflow_client/src/features/jobs/data/models/file_model.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/file_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/files_repository.dart';
import 'package:dartz/dartz.dart';

import '../sources/files_remote_data_source.dart';

class FilesRepositoryImp implements FilesRepository {
  final FilesRemoteDatasource remoteDatasource;

  FilesRepositoryImp({required this.remoteDatasource});

  @override
  Future<Either<Failure, void>> delete(int id) async {
    try {
      return Right(await remoteDatasource.deleteFile(id));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(ClientFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, FileModel>> upload(File file) async {
    try {
      return Right(await remoteDatasource.upload(file));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(ClientFailure(message: e.toString()));
    } on BadResponseException {
      return Left(
        ServerFailure(
          message:
              "The server couldn't upload the file; please try again later.",
        ),
      );
    }
  }
}
