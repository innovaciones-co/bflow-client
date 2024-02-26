import 'package:bflow_client/src/core/api/api.dart';
import 'package:bflow_client/src/core/data/sources/remote_data_source.dart';
import 'package:bflow_client/src/features/jobs/data/models/template_model.dart';

class TemplateRemoteDataSource extends RemoteDataSource {
  TemplateRemoteDataSource({required super.apiService});

  Future<List<TemplateModel>> fetchTemplates() async {
    List<dynamic> response =
        await apiService.get(endpoint: ApiConstants.templatesEndpoint);
    return response.map((e) => TemplateModel.fromMap(e)).toList();
  }

  Future<void> createTasksFromTemplate(int templateId, int jobId) async {
    await apiService.post(
      endpoint: ApiConstants.createTaskFromTemplateEndpoint.replaceAll(
        ':id',
        templateId.toString(),
      ),
      queryParams: {'jobId': jobId},
    );
  }
}
