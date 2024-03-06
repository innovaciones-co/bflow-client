import 'package:bflow_client/src/core/api/api.dart';
import 'package:bflow_client/src/core/data/sources/remote_data_source.dart';
import 'package:bflow_client/src/features/jobs/data/models/file_model.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/file_entity.dart';

class FilesRemoteDatasource extends RemoteDataSource {
  FilesRemoteDatasource({required super.apiService});

  Future<FileModel> upload(File file) async {
    final fileModel = FileModel.fromEntity(file);
    var data = await fileModel.toCreateMap();
    int fileId = await apiService.post(
      endpoint: ApiConstants.uploadFileEndpoint,
      data: data,
      encodeJson: false,
      headers: {'Content-Type': 'multipart/form-data'},
      formData: true,
    );

    return fetchFile(fileId);
  }

  Future<FileModel> fetchFile(int id) async {
    Map<String, dynamic> response = await apiService.get(
      endpoint: ApiConstants.fileEndpoint.replaceFirst(':id', id.toString()),
    );
    return FileModel.fromMap(response);
  }

  Future<void> deleteFile(int id) {
    return apiService.delete(
      endpoint: ApiConstants.fileEndpoint.replaceFirst(':id', id.toString()),
    );
  }
}
