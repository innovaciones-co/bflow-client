import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/file_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/files_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class UploadFilesUseCase extends UseCase<void, UploadFilesParams> {
  final FilesRepository repository;

  UploadFilesUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> execute(UploadFilesParams params) async {
    for (var file in params.files) {
      debugPrint("Uploading file ${file.name}");
      final result = await repository.upload(file);
      if (result.isLeft()) {
        return result;
      }
    }

    return const Right(null);
  }
}

class UploadFilesParams {
  final List<File> files;

  UploadFilesParams({required this.files});
}
