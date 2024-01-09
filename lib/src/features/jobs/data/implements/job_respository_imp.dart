import 'package:bflow_client/src/features/jobs/domain/entities/job_entity.dart';

import '../sources/sources.dart';
import '../../domain/repositories/repositories.dart';

class JobsRepositoryImp implements JobsRepository {
  final JobsRemoteDataSource remoteDataSource;
  JobsRepositoryImp({required this.remoteDataSource});

  @override
  Future<JobEntity> createJob(JobEntity job) {
    // TODO: implement createJob
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteJob(int id) {
    // TODO: implement deleteJob
    throw UnimplementedError();
  }

  @override
  Future<JobEntity> getJob(int id) {
    // TODO: implement getJob
    throw UnimplementedError();
  }

  @override
  Future<List<JobEntity>> getJobs() {
    // TODO: implement getJobs
    throw UnimplementedError();
  }

  @override
  Future<JobEntity> updateJob(JobEntity job) {
    // TODO: implement updateJob
    throw UnimplementedError();
  }

  // ... example ...
  //
  // Future<User> getUser(String userId) async {
  //     return remoteDataSource.getUser(userId);
  //   }
  // ...
}
