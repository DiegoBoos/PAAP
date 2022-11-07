import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:paap/domain/cubits/menu/menu_cubit.dart';

import 'data/datasources/local/actividad_financiera/actividad_financiera_local_ds.dart';
import 'data/datasources/local/agrupacion/agrupacion_local_ds.dart';
import 'data/datasources/local/aliado/aliado_local_ds.dart';
import 'data/datasources/local/alianzas/alianzas_local_ds.dart';
import 'data/datasources/local/beneficiario/beneficiario_local_ds.dart';
import 'data/datasources/local/cofinanciador/cofinanciador_local_ds.dart';
import 'data/datasources/local/consultor/consultor_local_ds.dart';
import 'data/datasources/local/departamento/departamento_local_ds.dart';
import 'data/datasources/local/desembolso/desembolso_local_ds.dart';
import 'data/datasources/local/estado_civil/estado_civil_local_ds.dart';
import 'data/datasources/local/estado_visita/estado_visita_local_ds.dart';
import 'data/datasources/local/frecuencia/frecuencia_local_ds.dart';
import 'data/datasources/local/genero/genero_local_ds.dart';
import 'data/datasources/local/grupo_especial/grupo_especial_local_ds.dart';
import 'data/datasources/local/municipio/municipio_local_ds.dart';
import 'data/datasources/local/nivel_escolar/nivel_escolar_local_ds.dart';
import 'data/datasources/local/producto/producto_local_ds.dart';
import 'data/datasources/local/residencia/residencia_local_ds.dart';
import 'data/datasources/local/revision/revision_local_ds.dart';
import 'data/datasources/local/rubro/rubro_local_ds.dart';
import 'data/datasources/local/tipo_calidad/tipo_calidad_local_ds.dart';
import 'data/datasources/local/tipo_entidad/tipo_entidad_local_ds.dart';
import 'data/datasources/local/tipo_identificacion/tipo_identificacion_local_ds.dart';
import 'data/datasources/local/tipo_movimiento/tipo_movimiento_local_ds.dart';
import 'data/datasources/local/tipo_tenencia/tipo_tenencia_local_ds.dart';
import 'data/datasources/local/tipo_visita/tipo_visita_local_ds.dart';
import 'data/datasources/local/vereda/vereda_local_ds.dart';
import 'data/datasources/remote/actividad_financiera/actividad_financiera_remote_ds.dart';
import 'data/datasources/remote/agrupacion/agrupacion_remote_ds.dart';
import 'data/datasources/remote/aliado/aliado_remote_ds.dart';
import 'data/datasources/remote/alianza/alianza_remote_ds.dart';
import 'data/datasources/remote/beneficiario/beneficiario_remote_ds.dart';
import 'data/datasources/remote/cofinanciador/cofinanciador_remote_ds.dart';
import 'data/datasources/remote/consultor/consultor_remote_ds.dart';
import 'data/datasources/remote/departamento/departamento_remote_ds.dart';
import 'data/datasources/remote/desembolso/desembolso_remote_ds.dart';
import 'data/datasources/remote/estado_civil/estado_civil_remote_ds.dart';
import 'data/datasources/remote/estado_visita/estado_visita_remote_ds.dart';
import 'data/datasources/remote/frecuencia/frecuencia_remote_ds.dart';
import 'data/datasources/remote/genero/genero_remote_ds.dart';
import 'data/datasources/remote/grupo_especial/grupo_especial_remote_ds.dart';
import 'data/datasources/remote/municipio/municipio_remote_ds.dart';
import 'data/datasources/remote/nivel_escolar/nivel_escolar_remote_ds.dart';
import 'data/datasources/remote/producto/producto_remote_ds.dart';
import 'data/datasources/remote/residencia/residencia_remote_ds.dart';
import 'data/datasources/remote/revision/revision_remote_ds.dart';
import 'data/datasources/remote/rubro/rubro_remote_ds.dart';
import 'data/datasources/remote/tipo_calidad/tipo_calidad_remote_ds.dart';
import 'data/datasources/remote/tipo_entidad/tipo_entidad_remote_ds.dart';
import 'data/datasources/remote/tipo_identificacion/tipo_identificacion_remote_ds.dart';
import 'data/datasources/remote/tipo_movimiento/tipo_movimiento_remote_ds.dart';
import 'data/datasources/remote/tipo_tenencia/tipo_tenencia_remote_ds.dart';
import 'data/datasources/remote/tipo_visita/tipo_visita_remote_ds.dart';
import 'data/datasources/remote/vereda/vereda_remote_ds.dart';
import 'data/repositories/actividad_financiera/actividad_financiera_repository.dart';
import 'data/repositories/actividad_financiera/actividad_financiera_repository_db.dart';
import 'data/repositories/agrupacion/agrupacion_repository.dart';
import 'data/repositories/agrupacion/agrupacion_repository_db.dart';
import 'data/repositories/aliado/aliado_repository.dart';
import 'data/repositories/aliado/aliado_repository_db.dart';
import 'data/repositories/alianza/alianza_repository.dart';
import 'data/repositories/alianza/alianza_repository_db.dart';
import 'data/repositories/beneficiario/beneficiario_repository.dart';
import 'data/repositories/beneficiario/beneficiario_repository_db.dart';
import 'data/repositories/cofinanciador/cofinanciador_repository.dart';
import 'data/repositories/cofinanciador/cofinanciador_repository_db.dart';
import 'data/repositories/consultor/consultor_repository.dart';
import 'data/repositories/consultor/consultor_repository_db.dart';
import 'data/repositories/departamento/departamento_repository.dart';
import 'data/repositories/departamento/departamento_repository_db.dart';
import 'data/repositories/desembolso/desembolso_repository.dart';
import 'data/repositories/desembolso/desembolso_repository_db.dart';
import 'data/repositories/estado_civil/estado_civil_repository.dart';
import 'data/repositories/estado_civil/estado_civil_repository_db.dart';
import 'data/repositories/estado_visita/estado_visita_repository.dart';
import 'data/repositories/estado_visita/estado_visita_repository_db.dart';
import 'data/repositories/frecuencia/frecuencia_repository.dart';
import 'data/repositories/frecuencia/frecuencia_repository_db.dart';
import 'data/repositories/genero/genero_repository.dart';
import 'data/repositories/genero/genero_repository_db.dart';
import 'data/repositories/grupo_especial/grupo_especial_repository.dart';
import 'data/repositories/grupo_especial/grupo_especial_repository_db.dart';
import 'data/repositories/municipio/municipio_repository.dart';
import 'data/repositories/municipio/municipio_repository_db.dart';
import 'data/repositories/nivel_escolar/nivel_escolar_repository.dart';
import 'data/repositories/nivel_escolar/nivel_escolar_repository_db.dart';
import 'data/repositories/producto/producto_repository.dart';
import 'data/repositories/producto/producto_repository_db.dart';
import 'data/repositories/residencia/residencia_repository.dart';
import 'data/repositories/residencia/residencia_repository_db.dart';
import 'data/repositories/revision/revision_repository.dart';
import 'data/repositories/revision/revision_repository_db.dart';
import 'data/repositories/rubro/rubro_repository.dart';
import 'data/repositories/rubro/rubro_repository_db.dart';
import 'data/repositories/tipo_calidad/tipo_calidad_repository.dart';
import 'data/repositories/tipo_calidad/tipo_calidad_repository_db.dart';
import 'data/repositories/tipo_entidad/tipo_entidad_repository.dart';
import 'data/repositories/tipo_entidad/tipo_entidad_repository_db.dart';
import 'data/repositories/tipo_identificacion/tipo_identificacion_repository.dart';
import 'data/repositories/tipo_identificacion/tipo_identificacion_repository_db.dart';
import 'data/repositories/tipo_movimiento/tipo_movimiento_repository.dart';
import 'data/repositories/tipo_movimiento/tipo_movimiento_repository_db.dart';
import 'data/repositories/tipo_tenencia/tipo_tenencia_repository.dart';
import 'data/repositories/tipo_tenencia/tipo_tenencia_repository_db.dart';
import 'data/repositories/tipo_visita/tipo_visita_repository.dart';
import 'data/repositories/tipo_visita/tipo_visita_repository_db.dart';
import 'data/repositories/vereda/vereda_repository.dart';
import 'data/repositories/vereda/vereda_repository_db.dart';
import 'domain/blocs/download_sync/download_sync_bloc.dart';
import 'domain/cubits/internet/internet_cubit.dart';
import 'domain/repositories/actividad_financiera/actividad_financiera_repository.dart';
import 'domain/repositories/actividad_financiera/actividad_financiera_repository_db.dart';
import 'domain/repositories/agrupacion/agrupacion_repository.dart';
import 'domain/repositories/agrupacion/agrupacion_repository_db.dart';
import 'domain/repositories/aliado/aliado_repository.dart';
import 'domain/repositories/aliado/aliado_repository_db.dart';
import 'domain/repositories/alianza/alianza_repository.dart';
import 'domain/repositories/alianza/alianza_repository_db.dart';
import 'domain/repositories/beneficiario/beneficiario_repository.dart';
import 'domain/repositories/beneficiario/beneficiario_repository_db.dart';
import 'domain/repositories/cofinanciador/cofinanciador_repository.dart';
import 'domain/repositories/cofinanciador/cofinanciador_repository_db.dart';
import 'domain/repositories/consultor/consultor_repository.dart';
import 'domain/repositories/consultor/consultor_repository_db.dart';
import 'domain/repositories/departamento/departamento_repository.dart';
import 'domain/repositories/departamento/departamento_repository_db.dart';
import 'domain/repositories/desembolso/desembolso_repository.dart';
import 'domain/repositories/desembolso/desembolso_repository_db.dart';
import 'domain/repositories/estado_civil/estado_civil_repository.dart';
import 'domain/repositories/estado_civil/estado_civil_repository_db.dart';
import 'domain/repositories/estado_visita/estado_visita_repository.dart';
import 'domain/repositories/estado_visita/estado_visita_repository_db.dart';
import 'domain/repositories/frecuencia/frecuencia_repository.dart';
import 'domain/repositories/frecuencia/frecuencia_repository_db.dart';
import 'domain/repositories/genero/genero_repository.dart';
import 'domain/repositories/genero/genero_repository_db.dart';
import 'domain/repositories/grupo_especial/grupo_especial_repository.dart';
import 'domain/repositories/grupo_especial/grupo_especial_repository_db.dart';
import 'domain/repositories/municipio/municipio_repository.dart';
import 'domain/repositories/municipio/municipio_repository_db.dart';
import 'domain/repositories/nivel_escolar/nivel_escolar_repository.dart';
import 'domain/repositories/nivel_escolar/nivel_escolar_repository_db.dart';
import 'domain/repositories/producto/producto_repository.dart';
import 'domain/repositories/producto/producto_repository_db.dart';
import 'domain/repositories/residencia/residencia_repository.dart';
import 'domain/repositories/residencia/residencia_repository_db.dart';
import 'domain/repositories/revision/revision_repository.dart';
import 'domain/repositories/revision/revision_repository_db.dart';
import 'domain/repositories/rubro/rubro_repository.dart';
import 'domain/repositories/rubro/rubro_repository_db.dart';
import 'domain/repositories/tipo_calidad/tipo_calidad_repository.dart';
import 'domain/repositories/tipo_calidad/tipo_calidad_repository_db.dart';
import 'domain/repositories/tipo_entidad/tipo_entidad_repository.dart';
import 'domain/repositories/tipo_entidad/tipo_entidad_repository_db.dart';
import 'domain/repositories/tipo_identificacion/tipo_identificacion_repository.dart';
import 'domain/repositories/tipo_identificacion/tipo_identificacion_repository_db.dart';
import 'domain/repositories/tipo_movimiento/tipo_movimiento_repository.dart';
import 'domain/repositories/tipo_movimiento/tipo_movimiento_repository_db.dart';
import 'domain/repositories/tipo_tenencia/tipo_tenencia_repository.dart';
import 'domain/repositories/tipo_tenencia/tipo_tenencia_repository_db.dart';
import 'domain/repositories/tipo_visita/tipo_visita_repository.dart';
import 'domain/repositories/tipo_visita/tipo_visita_repository_db.dart';
import 'domain/repositories/vereda/vereda_repository.dart';
import 'domain/repositories/vereda/vereda_repository_db.dart';
import 'domain/usecases/actividad_financiera/actividad_financiera_db_usecase.dart';
import 'domain/usecases/actividad_financiera/actividad_financiera_usecase.dart';
import 'domain/usecases/agrupacion/agrupacion_db_usecase.dart';
import 'domain/usecases/agrupacion/agrupacion_usecase.dart';
import 'domain/usecases/aliado/aliado_db_usecase.dart';
import 'domain/usecases/aliado/aliado_usecase.dart';
import 'domain/usecases/alianza/alianza_db_usecase.dart';
import 'domain/usecases/alianza/alianza_usecase.dart';
import 'domain/usecases/auth/auth_exports.dart';
import 'domain/usecases/beneficiario/beneficiario_db_usecase.dart';
import 'domain/usecases/beneficiario/beneficiario_usecase.dart';
import 'domain/usecases/cofinanciador/cofinanciador_db_usecase.dart';
import 'domain/usecases/cofinanciador/cofinanciador_usecase.dart';
import 'domain/usecases/consultor/consultor_db_usecase.dart';
import 'domain/usecases/consultor/consultor_usecase.dart';
import 'domain/usecases/departamento/departamento_db_usecase.dart';
import 'domain/usecases/departamento/departamento_usecase.dart';
import 'domain/usecases/desembolso/desembolso_db_usecase.dart';
import 'domain/usecases/desembolso/desembolso_usecase.dart';
import 'domain/usecases/estado_civil/estado_civil_db_usecase.dart';
import 'domain/usecases/estado_civil/estado_civil_usecase.dart';
import 'domain/usecases/estado_visita/estado_visita_db_usecase.dart';
import 'domain/usecases/estado_visita/estado_visita_usecase.dart';
import 'domain/usecases/frecuencia/frecuencia_db_usecase.dart';
import 'domain/usecases/frecuencia/frecuencia_usecase.dart';
import 'domain/usecases/genero/genero_db_usecase.dart';
import 'domain/usecases/genero/genero_usecase.dart';
import 'domain/usecases/grupo_especial/grupo_especial_db_usecase.dart';
import 'domain/usecases/grupo_especial/grupo_especial_usecase.dart';
import 'domain/usecases/menu/menu_exports.dart';
import 'domain/usecases/convocatoria/convocatoria_exports.dart';
import 'domain/usecases/municipio/municipio_db_usecase.dart';
import 'domain/usecases/municipio/municipio_usecase.dart';
import 'domain/usecases/nivel_escolar/nivel_escolar_db_usecase.dart';
import 'domain/usecases/nivel_escolar/nivel_escolar_usecase.dart';
import 'domain/usecases/perfiles/perfiles_exports.dart';
import 'domain/usecases/producto/producto_db_usecase.dart';
import 'domain/usecases/producto/producto_usecase.dart';
import 'domain/usecases/residencia/residencia_db_usecase.dart';
import 'domain/usecases/residencia/residencia_usecase.dart';
import 'domain/usecases/revision/revision_db_usecase.dart';
import 'domain/usecases/revision/revision_usecase.dart';
import 'domain/usecases/rubro/rubro_db_usecase.dart';
import 'domain/usecases/rubro/rubro_usecase.dart';
import 'domain/usecases/tipo_calidad/tipo_calidad_db_usecase.dart';
import 'domain/usecases/tipo_calidad/tipo_calidad_usecase.dart';
import 'domain/usecases/tipo_entidad/tipo_entidad_db_usecase.dart';
import 'domain/usecases/tipo_entidad/tipo_entidad_usecase.dart';
import 'domain/usecases/tipo_identificacion/tipo_identificacion_db_usecase.dart';
import 'domain/usecases/tipo_identificacion/tipo_identificacion_usecase.dart';
import 'domain/usecases/tipo_movimiento/tipo_movimiento_db_usecase.dart';
import 'domain/usecases/tipo_movimiento/tipo_movimiento_usecase.dart';
import 'domain/usecases/tipo_proyecto/tipo_proyecto_exports.dart';
import 'domain/usecases/tipo_tenencia/tipo_tenencia_db_usecase.dart';
import 'domain/usecases/tipo_tenencia/tipo_tenencia_usecase.dart';
import 'domain/usecases/tipo_visita/tipo_visita_db_usecase.dart';
import 'domain/usecases/tipo_visita/tipo_visita_usecase.dart';
import 'domain/usecases/unidad/unidad_exports.dart';
import 'domain/usecases/vereda/vereda_db_usecase.dart';
import 'domain/usecases/vereda/vereda_usecase.dart';

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
  agrupacionInit();
  estadoCivilInit();
  residenciaInit();
  tipoTenenciaInit();
  nivelEscolarInit();
  veredaInit();
  alianzaInit();
  aliadoInit();
  frecuenciaInit();
  beneficiarioInit();
  grupoEspecialInit();
  tipoIdentificacionInit();
  revisionInit();
  consultorInit();
  tipoEntidadInit();
  cofinanciadorInit();
  desembolsoInit();
  rubroInit();
  actividadFinancieraInit();
  tipoMovimientoInit();
  tipoCalidadInit();

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
        agrupacion: locator(),
        agrupacionDB: locator(),
        estadoCivil: locator(),
        estadoCivilDB: locator(),
        residencia: locator(),
        residenciaDB: locator(),
        tipoTenencia: locator(),
        tipoTenenciaDB: locator(),
        nivelEscolar: locator(),
        nivelEscolarDB: locator(),
        vereda: locator(),
        veredaDB: locator(),
        alianza: locator(),
        alianzaDB: locator(),
        aliado: locator(),
        aliadoDB: locator(),
        frecuencia: locator(),
        frecuenciaDB: locator(),
        beneficiario: locator(),
        beneficiarioDB: locator(),
        grupoEspecial: locator(),
        grupoEspecialDB: locator(),
        tipoIdentificacion: locator(),
        tipoIdentificacionDB: locator(),
        revision: locator(),
        revisionDB: locator(),
        consultor: locator(),
        consultorDB: locator(),
        tipoEntidad: locator(),
        tipoEntidadDB: locator(),
        cofinanciador: locator(),
        cofinanciadorDB: locator(),
        desembolso: locator(),
        desembolsoDB: locator(),
        rubro: locator(),
        rubroDB: locator(),
        actividadFinanciera: locator(),
        actividadFinancieraDB: locator(),
        tipoMovimiento: locator(),
        tipoMovimientoDB: locator(),
        tipoCalidad: locator(),
        tipoCalidadDB: locator(),
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

agrupacionInit() {
  // remote usecase
  locator.registerLazySingleton(() => AgrupacionUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => AgrupacionUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<AgrupacionRepository>(
    () => AgrupacionRepositoryImpl(
      agrupacionRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<AgrupacionRepositoryDB>(
    () => AgrupacionRepositoryDBImpl(
      agrupacionLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<AgrupacionRemoteDataSource>(
    () => AgrupacionRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<AgrupacionLocalDataSource>(
    () => AgrupacionLocalDataSourceImpl(),
  );
}

estadoCivilInit() {
  // remote usecase
  locator.registerLazySingleton(() => EstadoCivilUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => EstadoCivilUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<EstadoCivilRepository>(
    () => EstadoCivilRepositoryImpl(
      estadoCivilRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<EstadoCivilRepositoryDB>(
    () => EstadoCivilRepositoryDBImpl(
      estadoCivilLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<EstadoCivilRemoteDataSource>(
    () => EstadoCivilRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<EstadoCivilLocalDataSource>(
    () => EstadoCivilLocalDataSourceImpl(),
  );
}

residenciaInit() {
  // remote usecase
  locator.registerLazySingleton(() => ResidenciaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => ResidenciaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<ResidenciaRepository>(
    () => ResidenciaRepositoryImpl(
      residenciaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<ResidenciaRepositoryDB>(
    () => ResidenciaRepositoryDBImpl(
      residenciaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<ResidenciaRemoteDataSource>(
    () => ResidenciaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<ResidenciaLocalDataSource>(
    () => ResidenciaLocalDataSourceImpl(),
  );
}

tipoTenenciaInit() {
  // remote usecase
  locator.registerLazySingleton(() => TipoTenenciaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => TipoTenenciaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TipoTenenciaRepository>(
    () => TipoTenenciaRepositoryImpl(
      tipoTenenciaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TipoTenenciaRepositoryDB>(
    () => TipoTenenciaRepositoryDBImpl(
      tipoTenenciaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TipoTenenciaRemoteDataSource>(
    () => TipoTenenciaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TipoTenenciaLocalDataSource>(
    () => TipoTenenciaLocalDataSourceImpl(),
  );
}

nivelEscolarInit() {
  // remote usecase
  locator.registerLazySingleton(() => NivelEscolarUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => NivelEscolarUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<NivelEscolarRepository>(
    () => NivelEscolarRepositoryImpl(
      nivelEscolarRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<NivelEscolarRepositoryDB>(
    () => NivelEscolarRepositoryDBImpl(
      nivelEscolarLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<NivelEscolarRemoteDataSource>(
    () => NivelEscolarRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<NivelEscolarLocalDataSource>(
    () => NivelEscolarLocalDataSourceImpl(),
  );
}

veredaInit() {
  // remote usecase
  locator.registerLazySingleton(() => VeredaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => VeredaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<VeredaRepository>(
    () => VeredaRepositoryImpl(
      veredaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<VeredaRepositoryDB>(
    () => VeredaRepositoryDBImpl(
      veredaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<VeredaRemoteDataSource>(
    () => VeredaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<VeredaLocalDataSource>(
    () => VeredaLocalDataSourceImpl(),
  );
}

alianzaInit() {
  // remote usecase
  locator.registerLazySingleton(() => AlianzaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => AlianzaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<AlianzaRepository>(
    () => AlianzaRepositoryImpl(
      alianzaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<AlianzaRepositoryDB>(
    () => AlianzaRepositoryDBImpl(
      alianzaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<AlianzaRemoteDataSource>(
    () => AlianzaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<AlianzasLocalDataSource>(
    () => AlianzasLocalDataSourceImpl(),
  );
}

aliadoInit() {
  // remote usecase
  locator.registerLazySingleton(() => AliadoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => AliadoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<AliadoRepository>(
    () => AliadoRepositoryImpl(
      aliadoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<AliadoRepositoryDB>(
    () => AliadoRepositoryDBImpl(
      aliadoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<AliadoRemoteDataSource>(
    () => AliadoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<AliadosLocalDataSource>(
    () => AliadosLocalDataSourceImpl(),
  );
}

frecuenciaInit() {
  // remote usecase
  locator.registerLazySingleton(() => FrecuenciaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => FrecuenciaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<FrecuenciaRepository>(
    () => FrecuenciaRepositoryImpl(
      frecuenciaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<FrecuenciaRepositoryDB>(
    () => FrecuenciaRepositoryDBImpl(
      frecuenciaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<FrecuenciaRemoteDataSource>(
    () => FrecuenciaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<FrecuenciaLocalDataSource>(
    () => FrecuenciaLocalDataSourceImpl(),
  );
}

beneficiarioInit() {
  // remote usecase
  locator.registerLazySingleton(() => BeneficiarioUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => BeneficiarioUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<BeneficiarioRepository>(
    () => BeneficiarioRepositoryImpl(
      beneficiarioRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<BeneficiarioRepositoryDB>(
    () => BeneficiarioRepositoryDBImpl(
      beneficiarioLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<BeneficiarioRemoteDataSource>(
    () => BeneficiarioRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<BeneficiarioLocalDataSource>(
    () => BeneficiarioLocalDataSourceImpl(),
  );
}

grupoEspecialInit() {
  // remote usecase
  locator.registerLazySingleton(() => GrupoEspecialUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => GrupoEspecialUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<GrupoEspecialRepository>(
    () => GrupoEspecialRepositoryImpl(
      grupoEspecialRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<GrupoEspecialRepositoryDB>(
    () => GrupoEspecialRepositoryDBImpl(
      grupoEspecialLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<GrupoEspecialRemoteDataSource>(
    () => GrupoEspecialRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<GrupoEspecialLocalDataSource>(
    () => GrupoEspecialLocalDataSourceImpl(),
  );
}

tipoIdentificacionInit() {
  // remote usecase
  locator.registerLazySingleton(() => TipoIdentificacionUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => TipoIdentificacionUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TipoIdentificacionRepository>(
    () => TipoIdentificacionRepositoryImpl(
      tipoIdentificacionRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TipoIdentificacionRepositoryDB>(
    () => TipoIdentificacionRepositoryDBImpl(
      tipoIdentificacionLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TipoIdentificacionRemoteDataSource>(
    () => TipoIdentificacionRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TipoIdentificacionLocalDataSource>(
    () => TipoIdentificacionLocalDataSourceImpl(),
  );
}

revisionInit() {
  // remote usecase
  locator.registerLazySingleton(() => RevisionUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => RevisionUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<RevisionRepository>(
    () => RevisionRepositoryImpl(
      revisionRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<RevisionRepositoryDB>(
    () => RevisionRepositoryDBImpl(
      revisionLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<RevisionRemoteDataSource>(
    () => RevisionRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<RevisionLocalDataSource>(
    () => RevisionLocalDataSourceImpl(),
  );
}

consultorInit() {
  // remote usecase
  locator.registerLazySingleton(() => ConsultorUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => ConsultorUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<ConsultorRepository>(
    () => ConsultorRepositoryImpl(
      consultorRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<ConsultorRepositoryDB>(
    () => ConsultorRepositoryDBImpl(
      consultorLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<ConsultorRemoteDataSource>(
    () => ConsultorRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<ConsultorLocalDataSource>(
    () => ConsultorLocalDataSourceImpl(),
  );
}

tipoEntidadInit() {
  // remote usecase
  locator.registerLazySingleton(() => TipoEntidadUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => TipoEntidadUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TipoEntidadRepository>(
    () => TipoEntidadRepositoryImpl(
      tipoEntidadRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TipoEntidadRepositoryDB>(
    () => TipoEntidadRepositoryDBImpl(
      tipoEntidadLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TipoEntidadRemoteDataSource>(
    () => TipoEntidadRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TipoEntidadLocalDataSource>(
    () => TipoEntidadLocalDataSourceImpl(),
  );
}

cofinanciadorInit() {
  // remote usecase
  locator.registerLazySingleton(() => CofinanciadorUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => CofinanciadorUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<CofinanciadorRepository>(
    () => CofinanciadorRepositoryImpl(
      cofinanciadorRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<CofinanciadorRepositoryDB>(
    () => CofinanciadorRepositoryDBImpl(
      cofinanciadorLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<CofinanciadorRemoteDataSource>(
    () => CofinanciadorRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<CofinanciadorLocalDataSource>(
    () => CofinanciadorLocalDataSourceImpl(),
  );
}

desembolsoInit() {
  // remote usecase
  locator.registerLazySingleton(() => DesembolsoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => DesembolsoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<DesembolsoRepository>(
    () => DesembolsoRepositoryImpl(
      desembolsoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<DesembolsoRepositoryDB>(
    () => DesembolsoRepositoryDBImpl(
      desembolsoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<DesembolsoRemoteDataSource>(
    () => DesembolsoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<DesembolsoLocalDataSource>(
    () => DesembolsoLocalDataSourceImpl(),
  );
}

rubroInit() {
  // remote usecase
  locator.registerLazySingleton(() => RubroUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => RubroUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<RubroRepository>(
    () => RubroRepositoryImpl(
      rubroRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<RubroRepositoryDB>(
    () => RubroRepositoryDBImpl(
      rubroLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<RubroRemoteDataSource>(
    () => RubroRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<RubroLocalDataSource>(
    () => RubroLocalDataSourceImpl(),
  );
}

actividadFinancieraInit() {
  // remote usecase
  locator.registerLazySingleton(() => ActividadFinancieraUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => ActividadFinancieraUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<ActividadFinancieraRepository>(
    () => ActividadFinancieraRepositoryImpl(
      actividadFinancieraRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<ActividadFinancieraRepositoryDB>(
    () => ActividadFinancieraRepositoryDBImpl(
      actividadFinancieraLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<ActividadFinancieraRemoteDataSource>(
    () => ActividadFinancieraRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<ActividadFinancieraLocalDataSource>(
    () => ActividadFinancieraLocalDataSourceImpl(),
  );
}

tipoMovimientoInit() {
  // remote usecase
  locator.registerLazySingleton(() => TipoMovimientoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => TipoMovimientoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TipoMovimientoRepository>(
    () => TipoMovimientoRepositoryImpl(
      tipoMovimientoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TipoMovimientoRepositoryDB>(
    () => TipoMovimientoRepositoryDBImpl(
      tipoMovimientoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TipoMovimientoRemoteDataSource>(
    () => TipoMovimientoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TipoMovimientoLocalDataSource>(
    () => TipoMovimientoLocalDataSourceImpl(),
  );
}

tipoCalidadInit() {
  // remote usecase
  locator.registerLazySingleton(() => TipoCalidadUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => TipoCalidadUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TipoCalidadRepository>(
    () => TipoCalidadRepositoryImpl(
      tipoCalidadRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TipoCalidadRepositoryDB>(
    () => TipoCalidadRepositoryDBImpl(
      tipoCalidadLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TipoCalidadRemoteDataSource>(
    () => TipoCalidadRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TipoCalidadLocalDataSource>(
    () => TipoCalidadLocalDataSourceImpl(),
  );
}
