import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:schedulle_app/data/datasource/auth_remote_datasource.dart';
import 'package:schedulle_app/data/datasource/request_remote_datasource.dart';
import 'package:schedulle_app/data/datasource/task_remote_data.dart';
import 'package:schedulle_app/data/service/request_repos_impl.dart';
import 'package:schedulle_app/data/service/task_repository_impl.dart';
import 'package:schedulle_app/domain/repositories/auth_repos.dart';
import 'package:schedulle_app/domain/repositories/request_repos.dart';
import 'package:schedulle_app/domain/repositories/task_repos.dart';
import 'package:schedulle_app/domain/usecase/addRequest.dart';
import 'package:schedulle_app/domain/usecase/addTask.dart';
import 'package:schedulle_app/domain/usecase/createAccount.dart';
import 'package:schedulle_app/domain/usecase/getRequest.dart';
import 'package:schedulle_app/domain/usecase/getTasks.dart';
import 'package:schedulle_app/domain/usecase/getUser.dart';
import 'package:schedulle_app/domain/usecase/login.dart';
import 'package:schedulle_app/domain/usecase/logout.dart';
import 'package:schedulle_app/presentation/bloc/Auth_bloc.dart';
import 'package:schedulle_app/data/service/auth_reposiroty_impl.dart';
import 'package:schedulle_app/presentation/bloc/request_bloc.dart';
import 'package:schedulle_app/presentation/bloc/task_bloc.dart';

final locator = GetIt.instance;

void init() {
  //bloc
  locator.registerFactory(
      () => AuthCubit(locator(), locator(), locator(), locator()));
  locator.registerFactory(() => TaskCubit(locator(), locator()));
  locator.registerFactory(() => RequestCubit(locator(), locator()));

  //use case
  locator.registerLazySingleton(
    () => CreateAccount(
      repos: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => Login(
      repos: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => Logout(
      repos: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => AddTask(
      repos: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetTasks(
      repos: locator(),
    ),
  );
  locator.registerLazySingleton(() => GetUser(repos: locator()));
  locator.registerLazySingleton(
    () => AddRequest(
      repos: locator(),
    ),
  );
  locator.registerLazySingleton(() => GetRequest(repos: locator()));

  //repository
  locator.registerLazySingleton<AuthRepos>(() => AuthReposImpl(
      authRemoteDataSource: locator(),
      firebaseFirestore: FirebaseFirestore.instance));
  locator.registerLazySingleton<TaskRepos>(() => TaskRepositoryImpl(
      dataSource: locator(), firebaseFirestore: FirebaseFirestore.instance));
  locator.registerLazySingleton<RequestRepos>(
      () => RequestReposImpl(requestRemote: locator()));

  //data
  locator.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteImpl());
  locator.registerLazySingleton<TaskRemote>(() => TaskRemoteImpl());
  locator.registerLazySingleton<RequestRemote>(() => RequestRemoteImpl());
}
