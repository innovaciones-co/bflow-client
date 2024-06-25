import 'package:bflow_client/src/core/data/sources/remote_data_source.dart';
import 'package:bflow_client/src/features/jobs/data/models/task_model.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';

import '../../../../core/api/api.dart';

class TasksRemoteDataSource extends RemoteDataSource {
  TasksRemoteDataSource({required super.apiService});

  Future<List<TaskModel>> fetchTasks({int? jobId}) async {
    if (jobId != null) {
      Map<String, String> queryParams = {'job_id': jobId.toString()};
      List<dynamic> response = await apiService.get(
          endpoint: ApiConstants.tasksEndpoint, params: queryParams);
      return response.map((e) => TaskModel.fromMap(e)).toList();
    }

    List<dynamic> response =
        await apiService.get(endpoint: ApiConstants.tasksEndpoint);
    return response.map((e) => TaskModel.fromMap(e)).toList();
  }

  Future<TaskModel> createTask(Task task) async {
    final taskModel = TaskModel.fromEntity(task);
    int taskId = await apiService.post(
      endpoint: ApiConstants.tasksEndpoint,
      data: taskModel.toMap(),
    );

    return fetchTask(taskId);
  }

  Future<TaskModel> updateTask(Task task) async {
    final taskModel = TaskModel.fromEntity(task);
    int taskId = await apiService.put(
      endpoint:
          ApiConstants.taskEndpoint.replaceAll(':id', taskModel.id.toString()),
      data: taskModel.toMap(),
    );

    return fetchTask(taskId);
  }

  Future<TaskModel> fetchTask(int taskId) async {
    Map<String, dynamic> response = await apiService.get(
        endpoint:
            ApiConstants.taskEndpoint.replaceFirst(':id', taskId.toString()));
    return TaskModel.fromMap(response);
  }

  Future<void> deleteTask(int id) async {
    await apiService.delete(
      endpoint: ApiConstants.taskEndpoint.replaceAll(':id', id.toString()),
    );
  }

  sendTasks(List<Task> tasks) async {
    final tasksIds = tasks.map((e) => e.id!).toList();
    await apiService.post(
      endpoint: ApiConstants.sendTasksEndpoint,
      data: tasksIds,
    );
  }

  Future<void> updateTasks(List<Task> tasks) async {
    List<Map<String, dynamic>> tasksModel =
        tasks.map((t) => TaskModel.fromEntity(t).toMap()).toList();
    await apiService.put(
      endpoint: ApiConstants.tasksEndpoint,
      data: tasksModel,
    );

    return;
  }
}
