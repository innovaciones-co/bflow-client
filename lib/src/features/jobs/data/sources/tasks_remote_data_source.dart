import 'package:bflow_client/src/core/data/sources/remote_data_source.dart';
import 'package:bflow_client/src/features/jobs/data/models/task_model.dart';

import '../../../../core/api/api.dart';

class TasksRemoteDataSource extends RemoteDataSource {
  TasksRemoteDataSource({required super.apiService});

  Future<List<TaskModel>> fetchTasks({int? jobId}) async {
    if (jobId != null) {
      Map<String, String> queryParams = {'job_id': jobId.toString()};
      List<dynamic> response = await apiService.get(
          endpoint: ApiConstants.listTasksEndpoint, params: queryParams);
      return response.map((e) => TaskModel.fromMap(e)).toList();
    }

    List<dynamic> response =
        await apiService.get(endpoint: ApiConstants.listTasksEndpoint);
    return response.map((e) => TaskModel.fromMap(e)).toList();
  }
}
