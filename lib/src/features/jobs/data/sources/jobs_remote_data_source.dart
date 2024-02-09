import 'package:bflow_client/src/core/api/api.dart';
import 'package:bflow_client/src/core/data/sources/remote_data_source.dart';
import 'package:bflow_client/src/features/jobs/data/models/job_model.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/job_entity.dart';

class JobsRemoteDataSource extends RemoteDataSource {
  JobsRemoteDataSource({required super.apiService});

  Future<List<JobModel>> fetchJobs() async {
    List<dynamic> response =
        await apiService.get(endpoint: ApiConstants.listJobsEndpoint);
    return response.map((e) => JobModel.fromMap(e)).toList();
  }

  Future<JobModel> fetchJob(int id) async {
    Map<String, dynamic> response = await apiService.get(
        endpoint:
            ApiConstants.getJobEndpoint.replaceFirst(':id', id.toString()));
    return JobModel.fromMap(response);
  }

  Future<JobModel> createJob(Job job) async {
    final jobModel = JobModel.fromEntity(job);
    int jobId = await apiService.post(
      endpoint: ApiConstants.listJobsEndpoint,
      data: jobModel.toMap(),
    );

    return fetchJob(jobId);
  }

  Future<JobModel> updateJob(Job job) async {
    final jobModel = JobModel.fromEntity(job);
    int jobId = await apiService.put(
      endpoint: ApiConstants.listJobsEndpoint,
      data: jobModel.toMap(),
    );

    return fetchJob(jobId);
  }

  Future<void> deleteJob(int id) async {
    await apiService.delete(
      endpoint: ApiConstants.getJobEndpoint.replaceAll(':id', id.toString()),
    );
  }
}
