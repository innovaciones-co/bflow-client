library dependency_injection;

import 'package:bflow_client/src/core/api/api_service.dart';
import 'package:bflow_client/src/features/contacts/data/implements/contacts_repository_imp.dart';
import 'package:bflow_client/src/features/contacts/data/sources/sources.dart';
import 'package:bflow_client/src/features/contacts/domain/repositories/contacts_repository.dart';
import 'package:bflow_client/src/features/contacts/domain/usecases/delete_contact_usecase.dart';
import 'package:bflow_client/src/features/contacts/domain/usecases/get_contact_usecase.dart';
import 'package:bflow_client/src/features/contacts/domain/usecases/get_contacts_usecase.dart';
import 'package:bflow_client/src/features/contacts/domain/usecases/update_contact_usecase.dart';
import 'package:bflow_client/src/features/contacts/presentation/cubit/contacts_cubit.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bflow_client/src/features/jobs/data/implements/files_repository_imp.dart';
import 'package:bflow_client/src/features/jobs/data/implements/notes_repository_imp.dart';
import 'package:bflow_client/src/features/jobs/data/implements/tasks_repository_imp.dart';
import 'package:bflow_client/src/features/jobs/data/implements/templates_repository_imp.dart';
import 'package:bflow_client/src/features/jobs/data/sources/files_remote_data_source.dart';
import 'package:bflow_client/src/features/jobs/data/sources/jobs_remote_data_source.dart';
import 'package:bflow_client/src/features/jobs/data/sources/notes_remote_data_source.dart';
import 'package:bflow_client/src/features/jobs/data/sources/tasks_remote_data_source.dart';
import 'package:bflow_client/src/features/jobs/data/sources/template_remote_data_source.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/files_repository.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/job_repository.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/note_repository.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/task_repository.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/template_repository.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/create_job_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/create_note_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/create_task_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/create_tasks_from_template_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/delete_task_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/get_job_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/get_task_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/get_tasks_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/get_templates_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/update_job_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/update_task_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/upload_files_use_case.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/files/files_cubit.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/task/task_cubit.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/templates/templates_cubit.dart';
import 'package:bflow_client/src/features/login/data/implements/login_repository_impl.dart';
import 'package:bflow_client/src/features/login/data/sources/login_remote_data_source.dart';
import 'package:bflow_client/src/features/login/domain/repositories/repositories.dart';
import 'package:bflow_client/src/features/login/domain/usecases/login_use_case.dart';
import 'package:bflow_client/src/features/login/presentation/bloc/login_bloc.dart';
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
    sl.registerFactory<LoginCubit>(
      () => LoginCubit(sl()),
    );
    sl.registerFactory<JobsBloc>(
      () => JobsBloc(sl(), sl()),
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
    sl.registerFactory<ContactsCubit>(
      () => ContactsCubit(sl()),
    );
    sl.registerFactory<TemplatesCubit>(
      () => TemplatesCubit(
        templatesUseCase: sl(),
        createTasksFromTemplateUseCase: sl(),
        tasksBloc: sl(),
      ),
    );
    sl.registerFactory<TaskCubit>(
      () => TaskCubit(
        getTaskUseCase: sl(),
        getJobUseCase: sl(),
        deleteTaskUseCase: sl(),
      ),
    );
    sl.registerFactory<FilesCubit>(
      () => FilesCubit(
        uploadFilesUseCase: sl(),
        jobBloc: sl(),
      ),
    );

    // Use cases

    sl.registerLazySingleton(
      () => LoginUseCase(repository: sl()),
    );
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
      () => UpdateJobUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => GetUsersUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => GetSupervisorsUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => GetContactUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => GetContactsUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => UpdateContactUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => DeleteContactUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => GetTemplatesUseCase(templateRepository: sl()),
    );
    sl.registerLazySingleton(
      () => CreateTasksFromTemplateUseCase(templateRepository: sl()),
    );
    sl.registerLazySingleton(
      () => CreateTaskUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => UpdateTaskUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => GetTaskUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => DeleteTaskUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => UploadFilesUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => CreateNoteUsecase(notesRepository: sl()),
    );

    // Repository
    sl.registerLazySingleton<TemplateRepository>(
      () => TemplatesRepositoryImp(templateRemoteDataSource: sl()),
    );
    sl.registerLazySingleton<TasksRepository>(
      () => TasksRepositoryImp(remoteDataSource: sl()),
    );
    sl.registerLazySingleton<JobsRepository>(
      () => JobsRepositoryImp(remoteDataSource: sl()),
    );
    sl.registerLazySingleton<UsersRepository>(
      () => UsersRepositoryImp(remoteDataSource: sl()),
    );
    sl.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImp(remoteDataSource: sl()),
    );
    sl.registerLazySingleton<ContactsRepository>(
      () => ContactsRepositoryImp(remoteDataSource: sl()),
    );
    sl.registerLazySingleton<FilesRepository>(
      () => FilesRepositoryImp(remoteDatasource: sl()),
    );
    sl.registerLazySingleton<NotesRepository>(
      () => NotesRepositoryImp(remoteDataSource: sl()),
    );

    // Data sources
    sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSource(apiService: sl()),
    );
    sl.registerLazySingleton<TasksRemoteDataSource>(
      () => TasksRemoteDataSource(apiService: sl()),
    );
    sl.registerLazySingleton<JobsRemoteDataSource>(
      () => JobsRemoteDataSource(apiService: sl()),
    );
    sl.registerLazySingleton<UsersRemoteDataSource>(
      () => UsersRemoteDataSource(apiService: sl()),
    );
    sl.registerLazySingleton<ContactsRemoteDataSource>(
      () => ContactsRemoteDataSource(apiService: sl()),
    );
    sl.registerLazySingleton(
      () => TemplateRemoteDataSource(apiService: sl()),
    );
    sl.registerLazySingleton(
      () => FilesRemoteDatasource(apiService: sl()),
    );
    sl.registerLazySingleton(
      () => NotesRemoteDataSource(apiService: sl()),
    );
  }
}
