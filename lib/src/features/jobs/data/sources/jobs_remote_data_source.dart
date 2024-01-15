import 'package:bflow_client/src/core/api/api.dart';
import 'package:bflow_client/src/features/jobs/data/models/job_model.dart';

class JobsRemoteDataSource {
  final ApiService apiService;
  JobsRemoteDataSource(this.apiService);

  Future<List<JobModel>> fetchJobs() async {
    List<dynamic> response =
        await apiService.get(ApiConstants.listJobsEndpoint);
    return response.map((e) => JobModel.fromMap(e)).toList();
  }
}
