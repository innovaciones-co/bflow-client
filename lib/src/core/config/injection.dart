library dependency_injection;

import 'package:bflow_client/src/core/api/api_service.dart';
import 'package:bflow_client/src/features/jobs/data/sources/jobs_remote_data_source.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/job_reposiroty.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../features/jobs/data/implements/jobs_repository_imp.dart';
import '../../features/jobs/domain/usecases/get_jobs_use_case.dart';
import '../../features/jobs/presentation/bloc/jobs_bloc.dart';

class DependencyInjection {
  static final sl = GetIt.asNewInstance();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    // API service
    sl.registerLazySingleton(
      () => ApiService(),
    );

    // BLoC
    sl.registerFactory(
      () => JobsBloc(sl()),
    );

    // Use cases
    sl.registerLazySingleton(
      () => GetJobsUseCase(repository: sl()),
    );

    // Repository
    sl.registerLazySingleton<JobsRepository>(
      () => JobsRepositoryImp(remoteDataSource: sl()),
    );

    // Data sources
    sl.registerLazySingleton(
      () => JobsRemoteDataSource(sl()),
    );
  }
}
