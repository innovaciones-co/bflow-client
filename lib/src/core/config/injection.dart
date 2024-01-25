library dependency_injection;

import 'package:bflow_client/src/core/api/api_service.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bflow_client/src/features/jobs/data/implements/tasks_repository_imp.dart';
import 'package:bflow_client/src/features/jobs/data/sources/jobs_remote_data_source.dart';
import 'package:bflow_client/src/features/jobs/data/sources/tasks_remote_data_source.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/job_repository.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/task_repository.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/create_job_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/get_job_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/get_tasks_use_case.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks_bloc.dart';
import 'package:bflow_client/src/features/users/data/implements/users_repository_imp.dart';
import 'package:bflow_client/src/features/users/data/sources/users_remote_data_source.dart';
import 'package:bflow_client/src/features/users/domain/repositories/users_repository.dart';
import 'package:bflow_client/src/features/users/domain/usecases/get_supervisors_use_case.dart';
import 'package:bflow_client/src/features/users/domain/usecases/get_users_use_case.dart';
import 'package:bflow_client/src/features/users/presentation/bloc/users_bloc.dart';
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
    sl.registerSingleton<HomeBloc>(
      HomeBloc(),
    );
    sl.registerFactory<JobsBloc>(
      () => JobsBloc(sl(), sl(), sl()),
    );
    sl.registerFactory<JobBloc>(
      () => JobBloc(sl(), sl()),
    );
    sl.registerFactory<TasksBloc>(
      () => TasksBloc(sl(), sl()),
    );
    sl.registerFactory<UsersBloc>(
      () => UsersBloc(sl()),
    );

    // Use cases
    sl.registerLazySingleton(
      () => GetJobsUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => GetJobUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => GetTasksUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => CreateJobUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => GetUsersUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => GetSupervisorsUseCase(repository: sl()),
    );

    // Repository
    sl.registerLazySingleton<TasksRepository>(
      () => TasksRepositoryImp(remoteDataSource: sl()),
    );
    sl.registerLazySingleton<JobsRepository>(
      () => JobsRepositoryImp(remoteDataSource: sl()),
    );
    sl.registerLazySingleton<UsersRepository>(
      () => UsersRepositoryImp(remoteDataSource: sl()),
    );

    // Data sources
    sl.registerLazySingleton<TasksRemoteDataSource>(
      () => TasksRemoteDataSource(apiService: sl()),
    );
    sl.registerLazySingleton<JobsRemoteDataSource>(
      () => JobsRemoteDataSource(apiService: sl()),
    );
    sl.registerLazySingleton<UsersRemoteDataSource>(
      () => UsersRemoteDataSource(apiService: sl()),
    );
  }
}
