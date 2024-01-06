
    import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class UsersRepositoryImp implements UsersRepository{

        final UsersRemoteDataSource remoteDataSource;
        UsersRepositoryImp({required this.remoteDataSource});
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    