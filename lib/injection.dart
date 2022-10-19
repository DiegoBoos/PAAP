import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:paap/domain/cubits/menu/menu_cubit.dart';
import 'package:paap/domain/usecases/menu.dart';
import 'package:paap/domain/usecases/menu_db.dart';
import 'package:paap/domain/usecases/verificacion_db.dart';

import 'data/datasources/local/auth/auth_local_data_source.dart';
import 'data/datasources/remote/auth/auth_remote_data_source.dart';
import 'data/repositories/auth/auth_repository.dart';
import 'domain/blocs/auth/auth_bloc.dart';
import 'domain/cubits/internet/internet_cubit.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/verificacion.dart';

final locator = GetIt.instance;

void init() {
  internetCubitInit();
  authBlocInit();
  menuCubitInit();
}

authBlocInit() {
  // bloc
  locator.registerFactory(() => AuthBloc(
        internetCubit: locator(),
        verificacion: locator(),
        verificacionDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => Verificacion(locator()));

  // local usecase
  locator.registerLazySingleton(() => VerificacionDB(locator()));

  // repository
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: locator(),
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

  // external
  locator.registerLazySingleton(() => http.Client());
}

internetCubitInit() {
  // bloc
  locator.registerFactory(() => InternetCubit(connectivity: Connectivity()));
}

menuCubitInit() {
  // menu remote usecase
  locator.registerLazySingleton(() => Menu(locator()));

  // menu local usecase
  locator.registerLazySingleton(() => MenuDB(locator()));

  // bloc
  locator.registerFactory(() => MenuCubit(menu: locator(), menuDB: locator()));
}
