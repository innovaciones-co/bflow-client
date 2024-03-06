// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/file_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/upload_files_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'files_state.dart';

class FilesCubit extends Cubit<FilesState> {
  final UploadFilesUseCase uploadFilesUseCase;

  FilesCubit({
    required this.uploadFilesUseCase,
  }) : super(FilesInitial());

  uploadFiles(List<File> files) async {
    emit(FilesLoading());

    UploadFilesParams params = UploadFilesParams(files: files);
    final result = await uploadFilesUseCase.execute(params);

    result.fold(
      (l) => emit(FilesError(failure: l)),
      (r) => emit(FilesUploaded()),
    );
  }
}
