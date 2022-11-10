import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:paap/data/repositories/opcion/opcion_repository.dart';
import 'package:paap/domain/usecases/visita/visita_exports.dart';

import 'data/datasources/local/opcion/opcion_local_ds.dart';
import 'data/datasources/remote/opcion/opcion_remote_ds.dart';
import 'data/repositories/opcion/opcion_repository_db.dart';
import 'domain/blocs/download_sync/download_sync_bloc.dart';
import 'domain/cubits/internet/internet_cubit.dart';
import 'domain/cubits/opcion/opcion_cubit.dart';
import 'domain/repositories/opcion/opcion_repository.dart';
import 'domain/repositories/opcion/opcion_repository_db.dart';
import 'domain/usecases/actividad_economica/actividad_economica_exports.dart';
import 'domain/usecases/actividad_financiera/actividad_financiera_exports.dart';
import 'domain/usecases/agrupacion/agrupacion_exports.dart';
import 'domain/usecases/aliado/aliado_exports.dart';
import 'domain/usecases/alianza/alianza_exports.dart';
import 'domain/usecases/auth/auth_exports.dart';
import 'domain/usecases/beneficiario/beneficiario_exports.dart';
import 'domain/usecases/beneficiario_alianza/beneficiario_alianza_exports.dart';
import 'domain/usecases/beneficiario_preinversion/beneficiario_preinversion_exports.dart';
import 'domain/usecases/cofinanciador/cofinanciador_exports.dart';
import 'domain/usecases/consultor/consultor_exports.dart';
import 'domain/usecases/convocatoria/convocatoria_exports.dart';
import 'domain/usecases/departamento/departamento_exports.dart';
import 'domain/usecases/desembolso/desembolso_exports.dart';
import 'domain/usecases/estado_civil/estado_civil_exports.dart';
import 'domain/usecases/estado_visita/estado_visita_exports.dart';
import 'domain/usecases/evaluacion/evaluacion_exports.dart';
import 'domain/usecases/frecuencia/frecuencia_exports.dart';
import 'domain/usecases/genero/genero_exports.dart';
import 'domain/usecases/grupo_especial/grupo_especial_exports.dart';
import 'domain/usecases/menu/menu_exports.dart';
import 'domain/usecases/municipio/municipio_exports.dart';
import 'domain/usecases/nivel_escolar/nivel_escolar_exports.dart';
import 'domain/usecases/opcion/opcion_db_usecase.dart';
import 'domain/usecases/opcion/opcion_usecase.dart';
import 'domain/usecases/perfiles/perfiles_exports.dart';
import 'domain/usecases/producto/producto_exports.dart';
import 'domain/usecases/residencia/residencia_exports.dart';
import 'domain/usecases/revision/revision_exports.dart';
import 'domain/usecases/rubro/rubro_exports.dart';
import 'domain/usecases/tipo_actividad_productiva/tipo_actividad_productiva_exports.dart';
import 'domain/usecases/tipo_calidad/tipo_calidad_exports.dart';
import 'domain/usecases/tipo_entidad/tipo_entidad_exports.dart';
import 'domain/usecases/tipo_identificacion/tipo_identificacion_exports.dart';
import 'domain/usecases/tipo_movimiento/tipo_movimiento_exports.dart';
import 'domain/usecases/tipo_proyecto/tipo_proyecto_exports.dart';
import 'domain/usecases/tipo_tenencia/tipo_tenencia_exports.dart';
import 'domain/usecases/tipo_visita/tipo_visita_exports.dart';
import 'domain/usecases/unidad/unidad_exports.dart';
import 'domain/usecases/vereda/vereda_exports.dart';

final locator = GetIt.instance;

void init() {
  actividadEconomicaInit();
  actividadFinancieraInit();
  agrupacionInit();
  aliadoInit();
  alianzaInit();
  authBlocInit();
  beneficiarioAlianzaInit();
  beneficiarioInit();
  beneficiarioPreinversionInit();
  cofinanciadorInit();
  consultorInit();
  convocatoriaInit();
  departamentoInit();
  desembolsoInit();
  downloadSyncInit();
  estadoCivilInit();
  estadoVisitaInit();
  frecuenciaInit();
  generosInit();
  grupoEspecialInit();
  internetCubitInit();
  menuCubitInit();
  municipiosInit();
  nivelEscolarInit();
  perfilesBlocInit();
  productosInit();
  residenciaInit();
  revisionInit();
  rubroInit();
  tipoActividadProductivaInit();
  tipoCalidadInit();
  tipoEntidadInit();
  tipoIdentificacionInit();
  tipoMovimientoInit();
  tipoProyectoInit();
  tipoTenenciaInit();
  tipoVisitaInit();
  unidadInit();
  veredaInit();
  visitaInit();
  evaluacionInit();
  opcionInit();
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
      tipoActividadProductiva: locator(),
      tipoActividadProductivaDB: locator(),
      actividadEconomica: locator(),
      actividadEconomicaDB: locator(),
      beneficiarioPreinversion: locator(),
      beneficiarioPreinversionDB: locator(),
      beneficiarioAlianza: locator(),
      beneficiarioAlianzaDB: locator(),
      opcion: locator(),
      opcionDB: locator()));
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
  // cubit
  locator.registerFactory(() => ConvocatoriaCubit(convocatoriaDB: locator()));
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
  // cubit
  locator.registerFactory(() => TipoProyectoCubit(tipoProyectoDB: locator()));
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
  // cubit
  locator.registerFactory(() => UnidadCubit(unidadDB: locator()));
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
  // cubit
  locator.registerFactory(() => ProductoCubit(productoDB: locator()));
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
  // cubit
  locator.registerFactory(() => GeneroCubit(generoDB: locator()));
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

departamentoInit() {
  // cubit
  locator.registerFactory(() => DepartamentoCubit(departamentoDB: locator()));
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
  // cubit
  locator.registerFactory(() => MunicipioCubit(municipioDB: locator()));
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
  // cubit
  locator.registerFactory(() => TipoVisitaCubit(tipoVisitaDB: locator()));
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
  // cubit
  locator.registerFactory(() => EstadoVisitaCubit(estadovisitaDB: locator()));
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
  // cubit
  locator.registerFactory(() => AgrupacionCubit(agrupacionDB: locator()));
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
  // cubit
  locator.registerFactory(() => EstadoCivilCubit(estadoCivilDB: locator()));
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
  // cubit
  locator.registerFactory(() => ResidenciaCubit(residenciaDB: locator()));
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
  // cubit
  locator.registerFactory(() => TipoTenenciaCubit(tipoTenenciaDB: locator()));
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
  // cubit
  locator.registerFactory(() => NivelEscolarCubit(nivelEscolarDB: locator()));
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
  // cubit
  locator.registerFactory(() => VeredaCubit(veredaDB: locator()));
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
  // bloc
  locator.registerFactory(() => AlianzasBloc(alianzasDB: locator()));

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
  // cubit
  locator.registerFactory(() => AliadoCubit(aliadoDB: locator()));
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
  // cubit
  locator.registerFactory(() => FrecuenciaCubit(frecuenciaDB: locator()));

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
  // cubit
  locator.registerFactory(() => BeneficiarioCubit(beneficiarioDB: locator()));

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
  // cubit
  locator.registerFactory(() => GrupoEspecialCubit(grupoEspecialDB: locator()));

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
  // cubit
  locator.registerFactory(
      () => TipoIdentificacionCubit(tipoIdentificacionDB: locator()));

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
  // cubit
  locator.registerFactory(() => RevisionCubit(revisionDB: locator()));

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
  // cubit
  locator.registerFactory(() => ConsultorCubit(consultorDB: locator()));

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
  // cubit
  locator.registerFactory(() => TipoEntidadCubit(tipoEntidadDB: locator()));

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
  // cubit
  locator.registerFactory(() => CofinanciadorCubit(cofinanciadorDB: locator()));
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
  // cubit
  locator.registerFactory(() => DesembolsoCubit(desembolsoDB: locator()));

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
  // cubit
  locator.registerFactory(() => RubroCubit(rubroDB: locator()));

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
  // cubit
  locator.registerFactory(
      () => ActividadFinancieraCubit(actividadFinancieraDB: locator()));

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
  // cubit
  locator
      .registerFactory(() => TipoMovimientoCubit(tipoMovimientoDB: locator()));

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
  // cubit
  locator.registerFactory(() => TipoCalidadCubit(tipoCalidadDB: locator()));

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

tipoActividadProductivaInit() {
  // cubit
  locator.registerFactory(
      () => TipoActividadProductivaCubit(tipoActividadProductivaDB: locator()));

  // remote usecase
  locator
      .registerLazySingleton(() => TipoActividadProductivaUsecase(locator()));

  // local usecase
  locator
      .registerLazySingleton(() => TipoActividadProductivaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TipoActividadProductivaRepository>(
    () => TipoActividadProductivaRepositoryImpl(
      tipoActividadProductivaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TipoActividadProductivaRepositoryDB>(
    () => TipoActividadProductivaRepositoryDBImpl(
      tipoActividadProductivaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TipoActividadProductivaRemoteDataSource>(
    () => TipoActividadProductivaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TipoActividadProductivaLocalDataSource>(
    () => TipoActividadProductivaLocalDataSourceImpl(),
  );
}

actividadEconomicaInit() {
  // cubit
  locator.registerFactory(
      () => ActividadEconomicaCubit(actividadEconomicaDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => ActividadEconomicaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => ActividadEconomicaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<ActividadEconomicaRepository>(
    () => ActividadEconomicaRepositoryImpl(
      actividadEconomicaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<ActividadEconomicaRepositoryDB>(
    () => ActividadEconomicaRepositoryDBImpl(
      actividadEconomicaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<ActividadEconomicaRemoteDataSource>(
    () => ActividadEconomicaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<ActividadEconomicaLocalDataSource>(
    () => ActividadEconomicaLocalDataSourceImpl(),
  );
}

beneficiarioPreinversionInit() {
  // cubit
  locator.registerFactory(() => BeneficiariosPreinversionBloc(
      beneficiarioPreinversionUsecaseDB: locator()));

  // remote usecase
  locator
      .registerLazySingleton(() => BeneficiarioPreinversionUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(
      () => BeneficiarioPreinversionUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<BeneficiarioPreinversionRepository>(
    () => BeneficiarioPreinversionRepositoryImpl(
      beneficiarioPreinversionRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<BeneficiarioPreinversionRepositoryDB>(
    () => BeneficiarioPreinversionRepositoryDBImpl(
      beneficiarioPreinversionLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<BeneficiarioPreinversionRemoteDataSource>(
    () => BeneficiarioPreinversionRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<BeneficiarioPreinversionLocalDataSource>(
    () => BeneficiarioPreinversionLocalDataSourceImpl(),
  );
}

beneficiarioAlianzaInit() {
  // cubit
  locator.registerFactory(
      () => BeneficiariosAlianzaBloc(beneficiarioAlianzaUsecaseDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => BeneficiarioAlianzaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => BeneficiarioAlianzaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<BeneficiarioAlianzaRepository>(
    () => BeneficiarioAlianzaRepositoryImpl(
      beneficiarioAlianzaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<BeneficiarioAlianzaRepositoryDB>(
    () => BeneficiarioAlianzaRepositoryDBImpl(
      beneficiarioAlianzaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<BeneficiarioAlianzaRemoteDataSource>(
    () => BeneficiarioAlianzaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<BeneficiarioAlianzaLocalDataSource>(
    () => BeneficiarioAlianzaLocalDataSourceImpl(),
  );
}

visitaInit() {
  // cubit
  locator.registerFactory(() => VisitaCubit(visitaDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => VisitaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => VisitaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<VisitaRepository>(
    () => VisitaRepositoryImpl(
      visitaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<VisitaRepositoryDB>(
    () => VisitaRepositoryDBImpl(
      visitaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<VisitaRemoteDataSource>(
    () => VisitaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<VisitaLocalDataSource>(
    () => VisitaLocalDataSourceImpl(),
  );
}

evaluacionInit() {
  // cubit
  locator.registerFactory(() => EvaluacionCubit(evaluacionDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => EvaluacionUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => EvaluacionUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<EvaluacionRepository>(
    () => EvaluacionRepositoryImpl(
      evaluacionRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<EvaluacionRepositoryDB>(
    () => EvaluacionRepositoryDBImpl(
      evaluacionLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<EvaluacionRemoteDataSource>(
    () => EvaluacionRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<EvaluacionLocalDataSource>(
    () => EvaluacionLocalDataSourceImpl(),
  );
}

opcionInit() {
  // cubit
  locator.registerFactory(() => OpcionCubit(opcionDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => OpcionUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => OpcionUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<OpcionRepository>(
    () => OpcionRepositoryImpl(
      opcionRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<OpcionRepositoryDB>(
    () => OpcionRepositoryDBImpl(
      opcionLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<OpcionRemoteDataSource>(
    () => OpcionRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<OpcionLocalDataSource>(
    () => OpcionLocalDataSourceImpl(),
  );
}
