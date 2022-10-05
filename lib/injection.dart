import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:paap/domain/blocs/internet/internet_cubit.dart';

import 'data/datasources/remote/auth/auth_remote_data_source.dart';
import 'data/repositories/auth/auth_repository.dart';
import 'domain/blocs/auth/auth_bloc.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/verificar_usuario.dart';

final locator = GetIt.instance;

void init() {
  internetCubitInit();
  authBlocInit();
}

authBlocInit() {
  // bloc
  locator.registerFactory(() => AuthBloc(verificarUsuario: locator()));

  // usecase
  locator.registerLazySingleton(() => VerificarUsuario(locator()));

  // repository
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: locator(),
    ),
  );

  // data source
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}

internetCubitInit() {
  // bloc
  locator.registerFactory(() => InternetCubit(connectivity: Connectivity()));
}
