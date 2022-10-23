import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:paap/data/datasources/local/perfiles/perfiles_local_ds.dart';
import 'package:paap/data/datasources/remote/perfiles/perfiles_remote_ds.dart';
import 'package:paap/data/repositories/menu/menu_repository.dart';
import 'package:paap/data/repositories/perfiles/perfiles_repository.dart';
import 'package:paap/domain/blocs/perfiles/perfiles_bloc.dart';
import 'package:paap/domain/blocs/menu/menu_bloc.dart';
import 'package:paap/domain/repositories/auth/auth_repository_db.dart';
import 'package:paap/domain/repositories/menu/menu_repository.dart';
import 'package:paap/domain/repositories/perfiles/perfiles_repository.dart';

import 'package:paap/domain/usecases/auth/verificacion_db_usecase.dart';
import 'package:paap/domain/usecases/perfiles/perfiles_db_usecase.dart';
import 'package:paap/domain/usecases/perfiles/perfiles_usecase.dart';

import 'data/datasources/local/auth/auth_local_ds.dart';
import 'data/datasources/local/menu/menu_local_ds.dart';
import 'data/datasources/remote/auth/auth_remote_ds.dart';
import 'data/datasources/remote/menu/menu_remote_ds.dart';
import 'data/repositories/auth/auth_repository.dart';
import 'data/repositories/auth/auth_repository_db.dart';
import 'data/repositories/menu/menu_repository_db.dart';
import 'data/repositories/perfiles/perfiles_repository_db.dart';
import 'domain/blocs/auth/auth_bloc.dart';
import 'domain/cubits/internet/internet_cubit.dart';
import 'domain/repositories/auth/auth_repository.dart';
import 'domain/repositories/menu/menu_repository_db.dart';
import 'domain/repositories/perfiles/perfiles_repository_db.dart';
import 'domain/usecases/auth/verificacion_usecase.dart';
import 'domain/usecases/menu/menu_db_usecase.dart';
import 'domain/usecases/menu/menu_usecase.dart';

final locator = GetIt.instance;

void init() {
  internetCubitInit();
  authBlocInit();
  menuBlocInit();
  perfilesBlocInit();
  // external
  locator.registerLazySingleton(() => http.Client());
}

internetCubitInit() {
  // bloc
  locator.registerFactory(() => InternetCubit(connectivity: Connectivity()));
}

authBlocInit() {
  // bloc
  locator.registerFactory(() => AuthBloc(
        verificacion: locator(),
        verificacionDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => VerificacionUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => VerificacionUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<AuthRepositoryDB>(
    () => AuthRepositoryDBImpl(
      authLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );
}

menuBlocInit() {
  // menu remote usecase
  locator.registerLazySingleton(() => MenuUsecase(locator()));

  // menu local usecase
  locator.registerLazySingleton(() => MenuUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<MenuRepository>(
    () => MenuRepositoryImpl(
      menuRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<MenuRepositoryDB>(
    () => MenuRepositoryDBImpl(
      menuLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<MenuRemoteDataSource>(
    () => MenuRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<MenuLocalDataSource>(
    () => MenuLocalDataSourceImpl(),
  );

  // bloc
  locator.registerFactory(() => MenuBloc(menu: locator(), menuDB: locator()));
}

perfilesBlocInit() {
  // bloc
  locator.registerFactory(() => PerfilesBloc(
        internetCubit: locator(),
        perfiles: locator(),
        perfilesDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => PerfilesUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => PerfilesUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<PerfilesRepository>(
    () => PerfilesRepositoryImpl(
      perfilRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<PerfilesRepositoryDB>(
    () => PerfilesRepositoryDBImpl(
      perfilesLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<PerfilesRemoteDataSource>(
    () => PerfilesRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<PerfilesLocalDataSource>(
    () => PerfilesLocalDataSourceImpl(),
  );
}
