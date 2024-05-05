import 'package:bflow_client/src/core/api/api.dart';
import 'package:bflow_client/src/core/data/sources/remote_data_source.dart';
import 'package:bflow_client/src/features/templates/data/models/template_model.dart';
import 'package:bflow_client/src/features/templates/domain/entities/template_type.dart';

class TemplateRemoteDataSource extends RemoteDataSource {
  TemplateRemoteDataSource({required super.apiService});

  Future<List<TemplateModel>> fetchTemplates(TemplateType templateType) async {
    List<dynamic> response = await apiService.get(
        endpoint: ApiConstants.templatesEndpoint,
        params: {"type": templateType.toJSON()});
    return response.map((e) => TemplateModel.fromMap(e)).toList();
  }

  Future<void> createTasksFromTemplate(int templateId, int jobId) async {
    await apiService.post(
      endpoint: ApiConstants.createFromTemplateEndpoint.replaceAll(
        ':id',
        templateId.toString(),
      ),
      queryParams: {'jobId': jobId},
    );
  }
}
