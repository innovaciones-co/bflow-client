import 'package:bflow_client/src/features/jobs/domain/entities/job_entity.dart';

abstract class JobsRepository {
  // Future<User> getUser(String userId);
  Future<JobEntity> getJob(int id);
  Future<JobEntity> createJob(JobEntity job);
  Future<JobEntity> updateJob(JobEntity job);
  Future<bool> deleteJob(int id);
  Future<List<JobEntity>> getJobs();
}
