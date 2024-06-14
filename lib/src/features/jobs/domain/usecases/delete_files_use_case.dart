import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/file_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/files_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteFilesUseCase extends UseCase<void, DeleteFilesParams> {
  final FilesRepository repository;

  DeleteFilesUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> execute(DeleteFilesParams params) async {
    for (var file in params.files) {
      final result = await repository.delete(file.id!);
      if (result.isLeft()) {
        return result;
      }
    }

    return const Right(null);
  }
}

class DeleteFilesParams {
  final List<File> files;

  DeleteFilesParams({required this.files});
}
