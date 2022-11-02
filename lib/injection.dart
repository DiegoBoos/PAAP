import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:paap/domain/cubits/menu/menu_cubit.dart';

import 'data/datasources/local/departamento/departamento_local_ds.dart';
import 'data/datasources/local/estado_visita/estado_visita_local_ds.dart';
import 'data/datasources/local/genero/genero_local_ds.dart';
import 'data/datasources/local/municipio/municipio_local_ds.dart';
import 'data/datasources/local/producto/producto_local_ds.dart';
import 'data/datasources/local/tipo_visita/tipo_visita_local_ds.dart';
import 'data/datasources/remote/departamento/departamento_remote_ds.dart';
import 'data/datasources/remote/estado_visita/estado_visita_remote_ds.dart';
import 'data/datasources/remote/genero/genero_remote_ds.dart';
import 'data/datasources/remote/municipio/municipio_remote_ds.dart';
import 'data/datasources/remote/producto/producto_remote_ds.dart';
import 'data/datasources/remote/tipo_visita/tipo_visita_remote_ds.dart';
import 'data/repositories/departamento/departamento_repository.dart';
import 'data/repositories/departamento/departamento_repository_db.dart';
import 'data/repositories/estado_visita/estado_visita_repository.dart';
import 'data/repositories/estado_visita/estado_visita_repository_db.dart';
import 'data/repositories/genero/genero_repository.dart';
import 'data/repositories/genero/genero_repository_db.dart';
import 'data/repositories/municipio/municipio_repository.dart';
import 'data/repositories/municipio/municipio_repository_db.dart';
import 'data/repositories/producto/producto_repository.dart';
import 'data/repositories/producto/producto_repository_db.dart';
import 'data/repositories/tipo_visita/tipo_visita_repository.dart';
import 'data/repositories/tipo_visita/tipo_visita_repository_db.dart';
import 'domain/blocs/download_sync/download_sync_bloc.dart';
import 'domain/cubits/internet/internet_cubit.dart';
import 'domain/repositories/departamento/departamento_repository.dart';
import 'domain/repositories/departamento/departamento_repository_db.dart';
import 'domain/repositories/estado_visita/estado_visita_repository.dart';
import 'domain/repositories/estado_visita/estado_visita_repository_db.dart';
import 'domain/repositories/genero/genero_repository.dart';
import 'domain/repositories/genero/genero_repository_db.dart';
import 'domain/repositories/municipio/municipio_repository.dart';
import 'domain/repositories/municipio/municipio_repository_db.dart';
import 'domain/repositories/producto/producto_repository.dart';
import 'domain/repositories/producto/producto_repository_db.dart';
import 'domain/repositories/tipo_visita/tipo_visita_repository.dart';
import 'domain/repositories/tipo_visita/tipo_visita_repository_db.dart';
import 'domain/usecases/auth/auth_exports.dart';
import 'domain/usecases/departamento/departamento_db_usecase.dart';
import 'domain/usecases/departamento/departamento_usecase.dart';
import 'domain/usecases/estado_visita/estado_visita_db_usecase.dart';
import 'domain/usecases/estado_visita/estado_visita_usecase.dart';
import 'domain/usecases/genero/genero_db_usecase.dart';
import 'domain/usecases/genero/genero_usecase.dart';
import 'domain/usecases/menu/menu_exports.dart';
import 'domain/usecases/convocatoria/convocatoria_exports.dart';
import 'domain/usecases/municipio/municipio_db_usecase.dart';
import 'domain/usecases/municipio/municipio_usecase.dart';
import 'domain/usecases/perfiles/perfiles_exports.dart';
import 'domain/usecases/producto/producto_db_usecase.dart';
import 'domain/usecases/producto/producto_usecase.dart';
import 'domain/usecases/tipo_proyecto/tipo_proyecto_exports.dart';
import 'domain/usecases/tipo_visita/tipo_visita_db_usecase.dart';
import 'domain/usecases/tipo_visita/tipo_visita_usecase.dart';
import 'domain/usecases/unidad/unidad_exports.dart';

final locator = GetIt.instance;

void init() {
  internetCubitInit();
  downloadSyncInit();
  authBlocInit();
  menuCubitInit();
  convocatoriaInit();
  tipoProyectoInit();
  unidadInit();
  productosInit();
  generosInit();
  departamentosInit();
  municipiosInit();
  tipoVisitaInit();
  estadoVisitaInit();

  perfilesBlocInit();

  // external
  locator.registerLazySingleton(() => http.Client());
}

downloadSyncInit() {
  // bloc
  locator.registerFactory(() => DownloadSyncBloc(
        menu: locator(),
        menuDB: locator(),
        convocatoria: locator(),
        convocatoriaDB: locator(),
        perfiles: locator(),
        perfilesDB: locator(),
        tipoProyecto: locator(),
        tipoProyectoDB: locator(),
        unidad: locator(),
        unidadDB: locator(),
        productos: locator(),
        productosDB: locator(),
        generos: locator(),
        generosDB: locator(),
        departamentos: locator(),
        departamentosDB: locator(),
        municipios: locator(),
        municipiosDB: locator(),
        tipoVisita: locator(),
        tipoVisitaDB: locator(),
        estadoVisita: locator(),
        estadoVisitaDB: locator(),
      ));
}

internetCubitInit() {
  // cubit
  locator.registerFactory(() => InternetCubit(connectivity: Connectivity()));
}

authBlocInit() {
  // bloc
  locator.registerFactory(() => AuthBloc(
        auth: locator(),
        authDB: locator(),
      ));

  // remote usecase
  locator.registerLazySingleton(() => AuthUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => AuthUsecaseDB(locator()));

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

menuCubitInit() {
  //cubit
  locator.registerFactory(() => MenuCubit(menu: locator(), menuDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => MenuUsecase(locator()));

  // local usecase
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
}

convocatoriaInit() {
  // remote usecase
  locator.registerLazySingleton(() => ConvocatoriaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => ConvocatoriaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<ConvocatoriaRepository>(
    () => ConvocatoriaRepositoryImpl(
      convocatoriaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<ConvocatoriaRepositoryDB>(
    () => ConvocatoriaRepositoryDBImpl(
      convocatoriaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<ConvocatoriaRemoteDataSource>(
    () => ConvocatoriaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<ConvocatoriaLocalDataSource>(
    () => ConvocatoriaLocalDataSourceImpl(),
  );
}

tipoProyectoInit() {
  // remote usecase
  locator.registerLazySingleton(() => TipoProyectoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => TipoProyectoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TipoProyectoRepository>(
    () => TipoProyectoRepositoryImpl(
      tipoProyectoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TipoProyectoRepositoryDB>(
    () => TipoProyectoRepositoryDBImpl(
      tipoProyectoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TipoProyectoRemoteDataSource>(
    () => TipoProyectoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TipoProyectoLocalDataSource>(
    () => TipoProyectoLocalDataSourceImpl(),
  );
}

unidadInit() {
  // remote usecase
  locator.registerLazySingleton(() => UnidadUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => UnidadUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<UnidadRepository>(
    () => UnidadRepositoryImpl(
      unidadRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<UnidadRepositoryDB>(
    () => UnidadRepositoryDBImpl(
      unidadLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<UnidadRemoteDataSource>(
    () => UnidadRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<UnidadLocalDataSource>(
    () => UnidadLocalDataSourceImpl(),
  );
}

perfilesBlocInit() {
  // bloc
  locator.registerFactory(() => PerfilesBloc(
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

productosInit() {
  // remote usecase
  locator.registerLazySingleton(() => ProductoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => ProductoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<ProductoRepository>(
    () => ProductoRepositoryImpl(
      productoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<ProductoRepositoryDB>(
    () => ProductoRepositoryDBImpl(
      productoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<ProductoRemoteDataSource>(
    () => ProductoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<ProductoLocalDataSource>(
    () => ProductoLocalDataSourceImpl(),
  );
}

generosInit() {
  // remote usecase
  locator.registerLazySingleton(() => GeneroUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => GeneroUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<GeneroRepository>(
    () => GeneroRepositoryImpl(
      generoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<GeneroRepositoryDB>(
    () => GeneroRepositoryDBImpl(
      generoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<GeneroRemoteDataSource>(
    () => GeneroRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<GeneroLocalDataSource>(
    () => GeneroLocalDataSourceImpl(),
  );
}

departamentosInit() {
  // remote usecase
  locator.registerLazySingleton(() => DepartamentoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => DepartamentoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<DepartamentoRepository>(
    () => DepartamentoRepositoryImpl(
      departamentoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<DepartamentoRepositoryDB>(
    () => DepartamentoRepositoryDBImpl(
      departamentoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<DepartamentoRemoteDataSource>(
    () => DepartamentoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<DepartamentoLocalDataSource>(
    () => DepartamentoLocalDataSourceImpl(),
  );
}

municipiosInit() {
  // remote usecase
  locator.registerLazySingleton(() => MunicipioUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => MunicipioUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<MunicipioRepository>(
    () => MunicipioRepositoryImpl(
      municipioRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<MunicipioRepositoryDB>(
    () => MunicipioRepositoryDBImpl(
      municipioLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<MunicipioRemoteDataSource>(
    () => MunicipioRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<MunicipioLocalDataSource>(
    () => MunicipioLocalDataSourceImpl(),
  );
}

tipoVisitaInit() {
  // remote usecase
  locator.registerLazySingleton(() => TipoVisitaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => TipoVisitaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TipoVisitaRepository>(
    () => TipoVisitaRepositoryImpl(
      tipoVisitaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TipoVisitaRepositoryDB>(
    () => TipoVisitaRepositoryDBImpl(
      tipoVisitaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TipoVisitaRemoteDataSource>(
    () => TipoVisitaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TipoVisitaLocalDataSource>(
    () => TipoVisitaLocalDataSourceImpl(),
  );
}

estadoVisitaInit() {
  // remote usecase
  locator.registerLazySingleton(() => EstadoVisitaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => EstadoVisitaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<EstadoVisitaRepository>(
    () => EstadoVisitaRepositoryImpl(
      estadoVisitaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<EstadoVisitaRepositoryDB>(
    () => EstadoVisitaRepositoryDBImpl(
      estadoVisitaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<EstadoVisitaRemoteDataSource>(
    () => EstadoVisitaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<EstadoVisitaLocalDataSource>(
    () => EstadoVisitaLocalDataSourceImpl(),
  );
}
