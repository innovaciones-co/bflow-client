import '../sources/sources.dart';
import '../../domain/repositories/repositories.dart';

class JobsRepositoryImp implements JobsRepository {
  final JobsRemoteDataSource remoteDataSource;
  JobsRepositoryImp({required this.remoteDataSource});

  // ... example ...
  //
  // Future<User> getUser(String userId) async {
  //     return remoteDataSource.getUser(userId);
  //   }
  // ...
}
