
    import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class LoginRepositoryImp implements LoginRepository{

        final LoginRemoteDataSource remoteDataSource;
        LoginRepositoryImp({required this.remoteDataSource});
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    