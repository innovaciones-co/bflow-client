library dependency_injection;

import 'package:bflow_client/src/core/api/api.dart';
import 'package:bflow_client/src/features/catalog/data/implements/categories_repository_imp.dart';
import 'package:bflow_client/src/features/catalog/data/implements/products_repository_imp.dart';
import 'package:bflow_client/src/features/catalog/data/sources/categories_remote_data_source.dart';
import 'package:bflow_client/src/features/catalog/data/sources/products_remote_data_source.dart';
import 'package:bflow_client/src/features/catalog/domain/repositories/category_repository.dart';
import 'package:bflow_client/src/features/catalog/domain/repositories/product_repository.dart';
import 'package:bflow_client/src/features/catalog/domain/usecases/create_category_use_case.dart';
import 'package:bflow_client/src/features/catalog/domain/usecases/create_product_usecase.dart';
import 'package:bflow_client/src/features/catalog/domain/usecases/delete_category_use_case.dart';
import 'package:bflow_client/src/features/catalog/domain/usecases/delete_product_usecase.dart';
import 'package:bflow_client/src/features/catalog/domain/usecases/get_categories_by_supplier_use_case.dart';
import 'package:bflow_client/src/features/catalog/domain/usecases/get_categories_use_case.dart';
import 'package:bflow_client/src/features/catalog/domain/usecases/get_products_use_case.dart';
import 'package:bflow_client/src/features/catalog/domain/usecases/update_category_use_case.dart';
import 'package:bflow_client/src/features/catalog/domain/usecases/update_product_usecase.dart';
import 'package:bflow_client/src/features/catalog/domain/usecases/upsert_products_use_case.dart';
import 'package:bflow_client/src/features/catalog/presentation/cubit/categories_cubit.dart';
import 'package:bflow_client/src/features/catalog/presentation/cubit/products_cubit.dart';
import 'package:bflow_client/src/features/catalog/presentation/cubit/upsert_products_cubit/upsert_products_cubit.dart';
import 'package:bflow_client/src/features/catalog/presentation/cubit/write_category_cubit/write_category_cubit.dart';
import 'package:bflow_client/src/features/contacts/data/implements/contacts_repository_imp.dart';
import 'package:bflow_client/src/features/contacts/data/sources/sources.dart';
import 'package:bflow_client/src/features/contacts/domain/repositories/contacts_repository.dart';
import 'package:bflow_client/src/features/contacts/domain/usecases/create_contact_usecase.dart';
import 'package:bflow_client/src/features/contacts/domain/usecases/delete_contact_usecase.dart';
import 'package:bflow_client/src/features/contacts/domain/usecases/get_contact_usecase.dart';
import 'package:bflow_client/src/features/contacts/domain/usecases/get_contacts_usecase.dart';
import 'package:bflow_client/src/features/contacts/domain/usecases/get_suppliers_use_case.dart';
import 'package:bflow_client/src/features/contacts/domain/usecases/update_contact_usecase.dart';
import 'package:bflow_client/src/features/contacts/presentation/cubit/contacts_cubit.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bflow_client/src/features/jobs/data/implements/files_repository_imp.dart';
import 'package:bflow_client/src/features/jobs/data/implements/notes_repository_imp.dart';
import 'package:bflow_client/src/features/jobs/data/implements/tasks_repository_imp.dart';
import 'package:bflow_client/src/features/jobs/data/sources/files_remote_data_source.dart';
import 'package:bflow_client/src/features/jobs/data/sources/jobs_remote_data_source.dart';
import 'package:bflow_client/src/features/jobs/data/sources/notes_remote_data_source.dart';
import 'package:bflow_client/src/features/jobs/data/sources/tasks_remote_data_source.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/files_repository.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/job_repository.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/note_repository.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/task_repository.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/create_job_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/create_note_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/create_task_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/create_tasks_from_template_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/delete_files_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/delete_task_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/get_job_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/get_task_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/get_tasks_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/send_tasks_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/update_job_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/update_task_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/update_tasks_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/upload_files_use_case.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/files/files_cubit.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job/job_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/task/task_cubit.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:bflow_client/src/features/login/data/implements/login_repository_impl.dart';
import 'package:bflow_client/src/features/login/data/sources/login_local_data_source.dart';
import 'package:bflow_client/src/features/login/data/sources/login_remote_data_source.dart';
import 'package:bflow_client/src/features/login/domain/repositories/repositories.dart';
import 'package:bflow_client/src/features/login/domain/usecases/get_logged_user_use_case.dart';
import 'package:bflow_client/src/features/login/domain/usecases/is_logged_use_case.dart';
import 'package:bflow_client/src/features/login/domain/usecases/login_use_case.dart';
import 'package:bflow_client/src/features/login/domain/usecases/logout_use_case.dart';
import 'package:bflow_client/src/features/login/presentation/bloc/login_bloc.dart';
import 'package:bflow_client/src/features/purchase_orders/data/implements/items_repository_imp.dart';
import 'package:bflow_client/src/features/purchase_orders/data/implements/purchase_orders_repository_imp.dart';
import 'package:bflow_client/src/features/purchase_orders/data/sources/items_remote_data_source.dart';
import 'package:bflow_client/src/features/purchase_orders/data/sources/purchase_orders_remote_data_source.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/repositories/item_repository.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/repositories/purchase_order_repository.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/usecases/create_item_use_case.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/usecases/create_purchase_order_use_case.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/usecases/delete_item_use_case.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/usecases/get_items_use_case.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/usecases/get_purchase_order_use_case.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/usecases/get_purchase_orders_by_job_use_case.dart';
import 'package:bflow_client/src/features/purchase_orders/presentation/bloc/items_bloc.dart';
import 'package:bflow_client/src/features/templates/data/implements/templates_repository_imp.dart';
import 'package:bflow_client/src/features/templates/data/sources/template_remote_data_source.dart';
import 'package:bflow_client/src/features/templates/domain/repositories/template_repository.dart';
import 'package:bflow_client/src/features/templates/domain/usecases/get_templates_use_case.dart';
import 'package:bflow_client/src/features/templates/presentation/cubit/templates_cubit.dart';
import 'package:bflow_client/src/features/users/data/implements/users_repository_imp.dart';
import 'package:bflow_client/src/features/users/data/sources/users_remote_data_source.dart';
import 'package:bflow_client/src/features/users/domain/repositories/users_repository.dart';
import 'package:bflow_client/src/features/users/domain/usecases/create_user_use_case.dart';
import 'package:bflow_client/src/features/users/domain/usecases/delete_user_usecase.dart';
import 'package:bflow_client/src/features/users/domain/usecases/get_supervisors_use_case.dart';
import 'package:bflow_client/src/features/users/domain/usecases/get_users_use_case.dart';
import 'package:bflow_client/src/features/users/domain/usecases/update_user_use_case.dart';
import 'package:bflow_client/src/features/users/presentation/bloc/users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/jobs/data/implements/jobs_repository_imp.dart';
import '../../features/jobs/domain/usecases/get_jobs_use_case.dart';
import '../../features/jobs/presentation/bloc/jobs_bloc.dart';

class DependencyInjection {
  static final sl = GetIt.asNewInstance();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    // API service

    sl.registerLazySingleton(
      () => SocketService.instance(url: SocketConstants.endpointUrl),
    );
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerSingleton<SharedPreferences>(sharedPreferences);
    /* sl.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance(),
    ); */
    sl.registerLazySingleton(
      () => ApiService(
        sharedPreferences: sharedPreferences,
      ),
    );

    // BLoC
    sl.registerSingleton<HomeBloc>(
      HomeBloc(),
    );
    sl.registerFactory<LoginCubit>(
      () => LoginCubit(
        loginUseCase: sl(),
        isLoggedUseCase: sl(),
        getLoggedUserUseCase: sl(),
        logoutUseCase: sl(),
      ),
    );
    sl.registerFactory<JobsBloc>(
      () => JobsBloc(sl(), sl()),
    );
    sl.registerFactory<JobBloc>(
      () => JobBloc(sl(), sl()),
    );
    sl.registerFactory<TasksBloc>(
      () => TasksBloc(
        jobBloc: sl(),
        getTasksUseCase: sl(),
        deleteTaskUseCase: sl(),
        sendTasksUseCase: sl(),
        updateTasksUseCase: sl(),
        homeBloc: sl(),
        socketService: sl(),
      ),
    );
    sl.registerFactory<UsersBloc>(
      () => UsersBloc(sl(), sl(), sl()),
    );
    sl.registerFactory<ContactsCubit>(
      () => ContactsCubit(
        deleteContactUseCase: sl(),
        getContactsUseCase: sl(),
        homeBloc: sl(),
      ),
    );
    sl.registerFactory<TemplatesCubit>(
      () => TemplatesCubit(
        templatesUseCase: sl(),
        createFromTemplateUseCase: sl(),
      ),
    );
    sl.registerFactory<TaskCubit>(
      () => TaskCubit(
        getTaskUseCase: sl(),
        getJobUseCase: sl(),
        deleteTaskUseCase: sl(),
        updateTaskUseCase: sl(),
        tasksBloc: sl(),
        homeBloc: sl(),
      ),
    );
    sl.registerFactory<FilesCubit>(
      () => FilesCubit(
        uploadFilesUseCase: sl(),
        deleteFilesUseCase: sl(),
        jobBloc: sl(),
      ),
    );
    sl.registerFactory<ItemsBloc>(
      () => ItemsBloc(
        getItemsUseCase: sl(),
        getCategoriesUseCase: sl(),
        getOrdersUseCase: sl(),
        getSuppliersUseCase: sl(),
        createPurchaseOrderUseCase: sl(),
        deleteItemUseCase: sl(),
        homeBloc: sl(),
      ),
    );
    sl.registerFactory<ProductsCubit>(
      () => ProductsCubit(
        getProductsUseCase: sl(),
        getCategoriesUseCase: sl(),
        getContactUseCase: sl(),
        deleteProductUseCase: sl(),
        homeBloc: sl(),
      ),
    );
    sl.registerFactory<CategoriesCubit>(
      () => CategoriesCubit(
        getCategoriesUseCase: sl(),
        deleteCategoryUseCase: sl(),
        homeBloc: sl(),
      ),
    );
    sl.registerFactory<WriteCategoryCubit>(
      () => WriteCategoryCubit(
        categoriesCubit: sl(),
        createCategorytUseCase: sl(),
        updateCategorytUseCase: sl(),
      ),
    );
    sl.registerFactory<UpsertProductsCubit>(
      () => UpsertProductsCubit(
          upsertProductsUseCase: sl(), getCategoriesUseCase: sl()),
    );

    // Use cases
    sl.registerLazySingleton(
      () => LoginUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => GetLoggedUserUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => LogoutUseCase(
        repository: sl(),
      ),
    );
    sl.registerLazySingleton(
      () => IsLoggedUseCase(repository: sl()),
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
      () => CreateContactUseCase(repository: sl()),
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
      () => UpdateTasksUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => GetTaskUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => DeleteTaskUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => SendTasksUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => UploadFilesUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => DeleteFilesUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => CreateNoteUsecase(notesRepository: sl()),
    );
    sl.registerLazySingleton(
      () => GetItemsUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => DeleteItemUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => GetProductsUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => GetPurchaseOrderUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => GetPurchaseOrdersByJobUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => CreatePurchaseOrderUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => CreateCategoryUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => UpdateCategoryUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => DeleteCategoryUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => GetCategoriesUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => CreateUserUseCase(sl()),
    );
    sl.registerLazySingleton(
      () => UpdateUserUseCase(sl()),
    );
    sl.registerLazySingleton<CreateItemUseCase>(
      () => CreateItemUseCase(
        repository: sl(),
        categoriesRepository: sl(),
      ),
    );
    sl.registerLazySingleton<GetSuppliersUseCase>(
      () => GetSuppliersUseCase(
        repository: sl(),
      ),
    );
    sl.registerLazySingleton<GetCategoriesBySupplierUseCase>(
      () => GetCategoriesBySupplierUseCase(
        repository: sl(),
      ),
    );
    sl.registerLazySingleton(
      () => DeleteUserUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => CreateProductUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => UpdateProductUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => DeleteProductUseCase(repository: sl()),
    );
    sl.registerLazySingleton(
      () => UpsertProductsUseCase(repository: sl()),
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
      () => LoginRepositoryImp(
        remoteDataSource: sl(),
        localDataSource: sl(),
        usersRemoteDataSource: sl(),
      ),
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
    sl.registerLazySingleton<ItemsRepository>(
      () => ItemsRepositoryImp(remoteDataSource: sl()),
    );
    sl.registerLazySingleton<CategoriesRepository>(
      () => CategoriesRepositoryImp(remoteDataSource: sl()),
    );
    sl.registerLazySingleton<ProductsRepository>(
      () => ProductsRepositoryImp(remoteDataSource: sl()),
    );
    sl.registerLazySingleton<PurchaseOrdersRepository>(
      () => PurchaseOrdersRepositoryImp(remoteDataSource: sl()),
    );

    // Data sources
    sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSource(apiService: sl()),
    );
    sl.registerLazySingleton<LoginLocalDataSource>(
      () => LoginLocalDataSource(prefs: sl()),
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
    sl.registerLazySingleton(
      () => CategoriesRemoteDataSource(apiService: sl()),
    );
    sl.registerLazySingleton(
      () => ProductsRemoteDataSource(apiService: sl()),
    );
    sl.registerLazySingleton(
      () => ItemsRemoteDataSource(apiService: sl()),
    );
    sl.registerLazySingleton(
      () => PurchaseOrdersRemoteDataSource(apiService: sl()),
    );
  }
}
