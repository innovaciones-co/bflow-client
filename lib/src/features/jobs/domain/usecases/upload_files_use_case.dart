import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/file_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/files_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class UploadFilesUseCase extends UseCase<List<File>, UploadFilesParams> {
  final FilesRepository repository;

  UploadFilesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<File>>> execute(UploadFilesParams params) async {
    List<File> uploadedFiles = [];
    for (var file in params.files) {
      debugPrint("Uploading file ${file.name}");
      final failureOrFile = await repository.upload(file);
      failureOrFile.fold((failure) {
        return Left(failure);
      }, (fileModel) {
        uploadedFiles.add(fileModel);
      });
    }

    return Right(uploadedFiles);
  }
}

class UploadFilesParams {
  final List<File> files;

  UploadFilesParams({required this.files});
}
