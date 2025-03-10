import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'domain/usecases/perfil_aliado/perfil_aliado_exports.dart';
import 'domain/usecases/perfil_cofinanciador/perfil_cofinanciador_exports.dart';
import 'ui/blocs/perfil_aliados/perfil_aliados_bloc.dart';
import 'ui/blocs/sync/sync_bloc.dart';
import 'ui/cubits/internet/internet_cubit.dart';
import 'ui/cubits/slider/slider_cubit.dart';
import 'ui/cubits/v_alianza/v_alianza_cubit.dart';
import 'domain/usecases/actividad_economica/actividad_economica_exports.dart';
import 'domain/usecases/actividad_financiera/actividad_financiera_exports.dart';
import 'domain/usecases/agrupacion/agrupacion_exports.dart';
import 'domain/usecases/aliado/aliado_exports.dart';
import 'domain/usecases/alianza/alianza_exports.dart';
import 'domain/usecases/alianza_beneficiario/alianza_beneficiario_exports.dart';
import 'domain/usecases/alianza_experiencia_agricola/alianza_experiencia_agricola_exports.dart';
import 'domain/usecases/alianza_experiencia_pecuaria/alianza_experiencia_pecuaria_exports.dart';
import 'domain/usecases/auth/auth_exports.dart';
import 'domain/usecases/beneficiario/beneficiario_exports.dart';
import 'domain/usecases/beneficio/beneficio_exports.dart';
import 'domain/usecases/cofinanciador/cofinanciador_exports.dart';
import 'domain/usecases/consultor/consultor_exports.dart';
import 'domain/usecases/convocatoria/convocatoria_exports.dart';
import 'domain/usecases/criterio/criterio_exports.dart';
import 'domain/usecases/departamento/departamento_exports.dart';
import 'domain/usecases/desembolso/desembolso_exports.dart';
import 'domain/usecases/estado_civil/estado_civil_exports.dart';
import 'domain/usecases/estado_visita/estado_visita_exports.dart';
import 'domain/usecases/evaluacion/evaluacion_exports.dart';
import 'domain/usecases/evaluacion_respuesta/evaluacion_respuesta_exports.dart';
import 'domain/usecases/experiencia_agricola/experiencia_agricola_exports.dart';
import 'domain/usecases/experiencia_pecuaria/experiencia_pecuaria_exports.dart';
import 'domain/usecases/frecuencia/frecuencia_exports.dart';
import 'domain/usecases/genero/genero_exports.dart';
import 'domain/usecases/grupo_especial/grupo_especial_exports.dart';
import 'domain/usecases/menu/menu_exports.dart';
import 'domain/usecases/municipio/municipio_exports.dart';
import 'domain/usecases/nivel_escolar/nivel_escolar_exports.dart';
import 'domain/usecases/opcion/opcion_exports.dart';
import 'domain/usecases/perfil/perfil_exports.dart';
import 'domain/usecases/perfil_beneficiario/perfil_beneficiario_exports.dart';
import 'domain/usecases/perfil_preinversion/perfil_preinversion_exports.dart';
import 'domain/usecases/perfil_preinversion_aliado/perfil_preinversion_aliado_exports.dart';
import 'domain/usecases/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_exports.dart';
import 'domain/usecases/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_exports.dart';
import 'domain/usecases/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_exports.dart';
import 'domain/usecases/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_exports.dart';
import 'domain/usecases/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_exports.dart';
import 'domain/usecases/perfil_preinversion_consultor/perfil_preinversion_consultor_exports.dart';
import 'domain/usecases/perfil_preinversion_plan_negocio/perfil_preinversion_plan_negocio_exports.dart';
import 'domain/usecases/perfil_preinversion_precio/perfil_preinversion_precio_exports.dart';
import 'domain/usecases/producto/producto_exports.dart';
import 'domain/usecases/residencia/residencia_exports.dart';
import 'domain/usecases/revision/revision_exports.dart';
import 'domain/usecases/rubro/rubro_exports.dart';
import 'domain/usecases/sitio_entrega/sitio_entrega_exports.dart';
import 'domain/usecases/sync_log/sync_log_exports.dart';
import 'domain/usecases/tipo_actividad_productiva/tipo_actividad_productiva_exports.dart';
import 'domain/usecases/tipo_calidad/tipo_calidad_exports.dart';
import 'domain/usecases/tipo_discapacidad/tipo_discapacidad_exports.dart';
import 'domain/usecases/tipo_entidad/tipo_entidad_exports.dart';
import 'domain/usecases/tipo_identificacion/tipo_identificacion_exports.dart';
import 'domain/usecases/tipo_movimiento/tipo_movimiento_exports.dart';
import 'domain/usecases/tipo_proyecto/tipo_proyecto_exports.dart';
import 'domain/usecases/tipo_tenencia/tipo_tenencia_exports.dart';
import 'domain/usecases/tipo_visita/tipo_visita_exports.dart';
import 'domain/usecases/unidad/unidad_exports.dart';
import 'domain/usecases/vereda/vereda_exports.dart';
import 'domain/usecases/visita/visita_exports.dart';

final locator = GetIt.instance;

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

aliadoInit() {
  // cubit
  locator.registerFactory(() => AliadoCubit(aliadoUsecaseDB: locator()));
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

alianzaInit() {
  // bloc
  locator.registerFactory(() => AlianzasBloc(alianzasDB: locator()));

  // cubit
  locator.registerFactory(() => VAlianzaCubit());

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

criterioInit() {
  // cubit
  locator.registerFactory(() => CriterioCubit(criterioDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => CriterioUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => CriterioUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<CriterioRepository>(
    () => CriterioRepositoryImpl(
      criterioRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<CriterioRepositoryDB>(
    () => CriterioRepositoryDBImpl(
      criterioLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<CriterioRemoteDataSource>(
    () => CriterioRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<CriterioLocalDataSource>(
    () => CriterioLocalDataSourceImpl(),
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

syncInit() {
  // bloc
  locator.registerFactory(() => SyncBloc(
        actividadEconomica: locator(),
        actividadEconomicaDB: locator(),
        actividadFinanciera: locator(),
        actividadFinancieraDB: locator(),
        agrupacion: locator(),
        agrupacionDB: locator(),
        alianza: locator(),
        alianzaDB: locator(),
        cofinanciador: locator(),
        cofinanciadorDB: locator(),
        consultor: locator(),
        consultorDB: locator(),
        convocatoria: locator(),
        convocatoriaDB: locator(),
        criterio: locator(),
        criterioDB: locator(),
        departamento: locator(),
        departamentoDB: locator(),
        desembolso: locator(),
        desembolsoDB: locator(),
        estadoCivil: locator(),
        estadoCivilDB: locator(),
        estadoVisita: locator(),
        estadoVisitaDB: locator(),
        frecuencia: locator(),
        frecuenciaDB: locator(),
        genero: locator(),
        generoDB: locator(),
        grupoEspecial: locator(),
        grupoEspecialDB: locator(),
        menu: locator(),
        menuDB: locator(),
        municipio: locator(),
        municipioDB: locator(),
        nivelEscolar: locator(),
        nivelEscolarDB: locator(),
        opcion: locator(),
        opcionDB: locator(),
        perfil: locator(),
        perfilDB: locator(),
        producto: locator(),
        productoDB: locator(),
        residencia: locator(),
        residenciaDB: locator(),
        revision: locator(),
        revisionDB: locator(),
        sitioEntrega: locator(),
        sitioEntregaDB: locator(),
        tipoCalidad: locator(),
        tipoCalidadDB: locator(),
        tipoActividadProductiva: locator(),
        tipoActividadProductivaDB: locator(),
        tipoDiscapacidad: locator(),
        tipoDiscapacidadDB: locator(),
        tipoEntidad: locator(),
        tipoEntidadDB: locator(),
        tipoIdentificacion: locator(),
        tipoIdentificacionDB: locator(),
        tipoMovimiento: locator(),
        tipoMovimientoDB: locator(),
        tipoProyecto: locator(),
        tipoProyectoDB: locator(),
        tipoTenencia: locator(),
        tipoTenenciaDB: locator(),
        tipoVisita: locator(),
        tipoVisitaDB: locator(),
        unidad: locator(),
        unidadDB: locator(),
        vereda: locator(),
        veredaDB: locator(),
        beneficio: locator(),
        beneficioDB: locator(),
        aliado: locator(),
        aliadoDB: locator(),
        alianzaBeneficiario: locator(),
        alianzaBeneficiarioDB: locator(),
        alianzaExperienciaAgricola: locator(),
        alianzaExperienciaAgricolaDB: locator(),
        alianzaExperienciaPecuaria: locator(),
        alianzaExperienciaPecuariaDB: locator(),
        beneficiario: locator(),
        beneficiarioDB: locator(),
        evaluacion: locator(),
        evaluacionDB: locator(),
        evaluacionRespuesta: locator(),
        evaluacionRespuestaDB: locator(),
        experienciaAgricola: locator(),
        experienciaAgricolaDB: locator(),
        experienciaPecuaria: locator(),
        experienciaPecuariaDB: locator(),
        perfilAliado: locator(),
        perfilAliadoDB: locator(),
        perfilBeneficiario: locator(),
        perfilBeneficiarioDB: locator(),
        perfilCofinanciador: locator(),
        perfilCofinanciadorDB: locator(),
        perfilPreInversion: locator(),
        perfilPreInversionDB: locator(),
        rubro: locator(),
        rubroDB: locator(),
        perfilPreInversionAliado: locator(),
        perfilPreInversionAliadoDB: locator(),
        perfilPreInversionBeneficiario: locator(),
        perfilPreInversionBeneficiarioDB: locator(),
        perfilPreInversionCofinanciador: locator(),
        perfilPreInversionCofinanciadorDB: locator(),
        perfilPreInversionCofinanciadorActividadFinanciera: locator(),
        perfilPreInversionCofinanciadorActividadFinancieraDB: locator(),
        perfilPreInversionCofinanciadorDesembolso: locator(),
        perfilPreInversionCofinanciadorDesembolsoDB: locator(),
        perfilPreInversionCofinanciadorRubro: locator(),
        perfilPreInversionCofinanciadorRubroDB: locator(),
        perfilPreInversionConsultor: locator(),
        perfilPreInversionConsultorDB: locator(),
        perfilPreInversionPlanNegocio: locator(),
        perfilPreInversionPlanNegocioDB: locator(),
        perfilPreInversionPrecio: locator(),
        perfilPreInversionPrecioDB: locator(),
        visita: locator(),
        visitaDB: locator(),
        syncLogDB: locator(),
      ));
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

evaluacionRespuestaInit() {
  // cubit
  locator.registerFactory(
      () => EvaluacionRespuestaCubit(evaluacionRespuestaDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => EvaluacionRespuestaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => EvaluacionRespuestaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<EvaluacionRespuestaRepository>(
    () => EvaluacionRespuestaRepositoryImpl(
      evaluacionRespuestaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<EvaluacionRespuestaRepositoryDB>(
    () => EvaluacionRespuestaRepositoryDBImpl(
      evaluacionRespuestaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<EvaluacionRespuestaRemoteDataSource>(
    () => EvaluacionRespuestaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<EvaluacionRespuestaLocalDataSource>(
    () => EvaluacionRespuestaLocalDataSourceImpl(),
  );
}

experienciaAgricolaInit() {
  // cubit
  locator.registerFactory(
      () => ExperienciaAgricolaCubit(experienciaAgricolaDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => ExperienciaAgricolaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => ExperienciaAgricolaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<ExperienciaAgricolaRepository>(
    () => ExperienciaAgricolaRepositoryImpl(
      experienciaAgricolaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<ExperienciaAgricolaRepositoryDB>(
    () => ExperienciaAgricolaRepositoryDBImpl(
      experienciaAgricolaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<ExperienciaAgricolaRemoteDataSource>(
    () => ExperienciaAgricolaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<ExperienciaAgricolaLocalDataSource>(
    () => ExperienciaAgricolaLocalDataSourceImpl(),
  );
}

experienciaPecuariaInit() {
  // cubit
  locator.registerFactory(
      () => ExperienciaPecuariaCubit(experienciaPecuariaDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => ExperienciaPecuariaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => ExperienciaPecuariaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<ExperienciaPecuariaRepository>(
    () => ExperienciaPecuariaRepositoryImpl(
      experienciaPecuariaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<ExperienciaPecuariaRepositoryDB>(
    () => ExperienciaPecuariaRepositoryDBImpl(
      experienciaPecuariaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<ExperienciaPecuariaRemoteDataSource>(
    () => ExperienciaPecuariaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<ExperienciaPecuariaLocalDataSource>(
    () => ExperienciaPecuariaLocalDataSourceImpl(),
  );
}

alianzaExperienciaAgricolaInit() {
  // cubit
  locator.registerFactory(() =>
      AlianzaExperienciaAgricolaCubit(alianzaExperienciaAgricolaDB: locator()));

  // remote usecase
  locator.registerLazySingleton(
      () => AlianzaExperienciaAgricolaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(
      () => AlianzaExperienciaAgricolaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<AlianzaExperienciaAgricolaRepository>(
    () => AlianzaExperienciaAgricolaRepositoryImpl(
      alianzaExperienciaAgricolaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<AlianzaExperienciaAgricolaRepositoryDB>(
    () => AlianzaExperienciaAgricolaRepositoryDBImpl(
      alianzaExperienciaAgricolaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<AlianzaExperienciaAgricolaRemoteDataSource>(
    () => AlianzaExperienciaAgricolaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<AlianzaExperienciaAgricolaLocalDataSource>(
    () => AlianzaExperienciaAgricolaLocalDataSourceImpl(),
  );
}

alianzaExperienciaPecuariaInit() {
  // cubit
  locator.registerFactory(() =>
      AlianzaExperienciaPecuariaCubit(alianzaExperienciaPecuariaDB: locator()));

  // remote usecase
  locator.registerLazySingleton(
      () => AlianzaExperienciaPecuariaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(
      () => AlianzaExperienciaPecuariaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<AlianzaExperienciaPecuariaRepository>(
    () => AlianzaExperienciaPecuariaRepositoryImpl(
      alianzaExperienciaPecuariaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<AlianzaExperienciaPecuariaRepositoryDB>(
    () => AlianzaExperienciaPecuariaRepositoryDBImpl(
      alianzaExperienciaPecuariaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<AlianzaExperienciaPecuariaRemoteDataSource>(
    () => AlianzaExperienciaPecuariaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<AlianzaExperienciaPecuariaLocalDataSource>(
    () => AlianzaExperienciaPecuariaLocalDataSourceImpl(),
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

syncLogInit() {
  // cubit
  locator.registerFactory(() => SyncLogCubit(syncLogDB: locator()));

  // local usecase
  locator.registerLazySingleton(() => SyncLogUsecaseDB(locator()));

  // repository DB
  locator.registerLazySingleton<SyncLogRepositoryDB>(
    () => SyncLogRepositoryDBImpl(
      syncLogLocalDataSource: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<SyncLogLocalDataSource>(
    () => SyncLogLocalDataSourceImpl(),
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

void init() {
  actividadEconomicaInit();
  actividadFinancieraInit();
  agrupacionInit();
  aliadoInit();
  alianzaInit();
  alianzaBeneficiarioInit();
  authBlocInit();
  beneficiarioInit();
  perfilPreInversionBeneficiarioInit();
  cofinanciadorInit();
  consultorInit();
  convocatoriaInit();
  departamentoInit();
  desembolsoInit();
  estadoCivilInit();
  estadoVisitaInit();
  frecuenciaInit();
  generosInit();
  grupoEspecialInit();
  internetCubitInit();
  menuCubitInit();
  municipiosInit();
  nivelEscolarInit();
  perfilesInit();
  perfilAliadoInit();
  perfilBeneficiarioInit();
  perfilCofinanciadorInit();
  perfilesPreInversionInit();
  perfilPreInversionAliadosInit();
  productosInit();
  residenciaInit();
  revisionInit();
  rubroInit();
  tipoActividadProductivaInit();
  tipoCalidadInit();
  tipoDiscapacidadInit();
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
  criterioInit();
  sitioEntregaInit();
  evaluacionRespuestaInit();
  perfilPreInversionCofinanciadorActividadFinancieraInit();
  perfilPreInversionCofinanciadorDesembolsoInit();
  perfilPreInversionCofinanciadorRubroInit();
  perfilPreInversionCofinanciadoresInit();
  perfilPreInversionConsultoresInit();
  perfilPreInversionPreciosInit();
  experienciaAgricolaInit();
  experienciaPecuariaInit();
  alianzaExperienciaAgricolaInit();
  alianzaExperienciaPecuariaInit();
  perfilPreInversionPlanesNegociosInit();
  beneficioInit();
  sliderInit();
  syncInit();
  syncLogInit();
  // external
  locator.registerLazySingleton(() => http.Client());
}

internetCubitInit() {
  // cubit
  locator.registerFactory(() => InternetCubit());
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

perfilAliadoInit() {
  // bloc
  locator.registerFactory(
      () => PerfilAliadosBloc(perfilAliadoUsecaseDB: locator()));

  // cubit
  locator.registerFactory(() => PerfilAliadoCubit(perfilAliadoDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => PerfilAliadoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => PerfilAliadoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<PerfilAliadoRepository>(
    () => PerfilAliadoRepositoryImpl(
      perfilAliadoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<PerfilAliadoRepositoryDB>(
    () => PerfilAliadoRepositoryDBImpl(
      perfilAliadoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<PerfilAliadoRemoteDataSource>(
    () => PerfilAliadoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<PerfilAliadoLocalDataSource>(
    () => PerfilAliadoLocalDataSourceImpl(),
  );
}

perfilBeneficiarioInit() {
  // cubit
  locator.registerFactory(
      () => PerfilBeneficiariosBloc(perfilBeneficiarioUsecaseDB: locator()));

  // cubit
  locator.registerFactory(
      () => PerfilBeneficiarioCubit(perfilBeneficiarioDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => PerfilBeneficiarioUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => PerfilBeneficiarioUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<PerfilBeneficiarioRepository>(
    () => PerfilBeneficiarioRepositoryImpl(
      perfilBeneficiarioRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<PerfilBeneficiarioRepositoryDB>(
    () => PerfilBeneficiarioRepositoryDBImpl(
      perfilBeneficiarioLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<PerfilBeneficiarioRemoteDataSource>(
    () => PerfilBeneficiarioRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<PerfilBeneficiarioLocalDataSource>(
    () => PerfilBeneficiarioLocalDataSourceImpl(),
  );
}

perfilCofinanciadorInit() {
  // bloc
  locator.registerFactory(
      () => PerfilCofinanciadoresBloc(perfilCofinanciadorUsecaseDB: locator()));

  // cubit
  locator.registerFactory(
      () => PerfilCofinanciadorCubit(perfilCofinanciadorUsecaseDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => PerfilCofinanciadorUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => PerfilCofinanciadorUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<PerfilCofinanciadorRepository>(
    () => PerfilCofinanciadorRepositoryImpl(
      perfilCofinanciadorRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<PerfilCofinanciadorRepositoryDB>(
    () => PerfilCofinanciadorRepositoryDBImpl(
      perfilCofinanciadorLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<PerfilCofinanciadorRemoteDataSource>(
    () => PerfilCofinanciadorRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<PerfilCofinanciadorLocalDataSource>(
    () => PerfilCofinanciadorLocalDataSourceImpl(),
  );
}

perfilesInit() {
  // bloc
  locator.registerFactory(() => PerfilesBloc(
        perfilesDB: locator(),
      ));
  // cubit
  locator.registerFactory(() => VPerfilCubit());

  // remote usecase
  locator.registerLazySingleton(() => PerfilUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => PerfilUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<PerfilRepository>(
    () => PerfilRepositoryImpl(
      perfilRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<PerfilRepositoryDB>(
    () => PerfilRepositoryDBImpl(
      perfilesLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<PerfilRemoteDataSource>(
    () => PerfilesRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<PerfilLocalDataSource>(
    () => PerfilLocalDataSourceImpl(),
  );
}

perfilesPreInversionInit() {
  // bloc
  locator.registerFactory(() => PerfilesPreInversionBloc(
        perfilesPreInversionDB: locator(),
      ));

  // cubit
  locator.registerFactory(() => VPerfilPreInversionCubit());

  // remote usecase
  locator.registerLazySingleton(() => PerfilPreInversionUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => PerfilPreInversionUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<PerfilPreInversionRepository>(
    () => PerfilPreInversionRepositoryImpl(
      perfilPreInversionRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<PerfilPreInversionRepositoryDB>(
    () => PerfilPreInversionRepositoryDBImpl(
      perfilesPreInversionLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<PerfilPreInversionRemoteDataSource>(
    () => PerfilesPreInversionRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<PerfilPreInversionLocalDataSource>(
    () => PerfilPreInversionLocalDataSourceImpl(),
  );
}

perfilPreInversionAliadosInit() {
  // bloc
  locator.registerFactory(() => PerfilPreInversionAliadosBloc(
        perfilPreInversionAliadosDB: locator(),
      ));

  // cubit
  locator.registerFactory(() =>
      PerfilPreInversionAliadoCubit(perfilPreInversionAliadoDB: locator()));

  // remote usecase
  locator
      .registerLazySingleton(() => PerfilPreInversionAliadoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(
      () => PerfilPreInversionAliadoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<PerfilPreInversionAliadoRepository>(
    () => PerfilPreInversionAliadoRepositoryImpl(
      perfilPreInversionAliadoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<PerfilPreInversionAliadoRepositoryDB>(
    () => PerfilPreInversionAliadoRepositoryDBImpl(
      perfilPreInversionAliadoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<PerfilPreInversionAliadoRemoteDataSource>(
    () => PerfilPreInversionAliadoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<PerfilPreInversionAliadoLocalDataSource>(
    () => PerfilPreInversionAliadoLocalDataSourceImpl(),
  );
}

perfilPreInversionBeneficiarioInit() {
  // bloc
  locator.registerFactory(() => PerfilPreInversionBeneficiariosBloc(
      perfilPreInversionBeneficiarioUsecaseDB: locator()));

  // cubit
  locator.registerFactory(() => PerfilPreInversionBeneficiarioCubit(
      perfilPreInversionBeneficiarioDB: locator()));

  // remote usecase
  locator.registerLazySingleton(
      () => PerfilPreInversionBeneficiarioUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(
      () => PerfilPreInversionBeneficiarioUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<PerfilPreInversionBeneficiarioRepository>(
    () => PerfilPreInversionBeneficiarioRepositoryImpl(
      perfilPreInversionBeneficiarioRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<PerfilPreInversionBeneficiarioRepositoryDB>(
    () => PerfilPreInversionBeneficiarioRepositoryDBImpl(
      perfilPreInversionBeneficiarioLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<PerfilPreInversionBeneficiarioRemoteDataSource>(
    () => PerfilPreInversionBeneficiarioRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<PerfilPreInversionBeneficiarioLocalDataSource>(
    () => PerfilPreInversionBeneficiarioLocalDataSourceImpl(),
  );
}

perfilPreInversionCofinanciadorActividadFinancieraInit() {
  // bloc
  locator.registerFactory(() =>
      PerfilPreInversionCofinanciadorActividadesFinancierasBloc(
          perfilPreInversionCofinanciadorActividadFinancieraUsecaseDB:
              locator()));

  // cubit
  locator.registerFactory(() =>
      PerfilPreInversionCofinanciadorActividadFinancieraCubit(
          perfilPreInversionCofinanciadorActividadFinancieraDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() =>
      PerfilPreInversionCofinanciadorActividadFinancieraUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() =>
      PerfilPreInversionCofinanciadorActividadFinancieraUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<
      PerfilPreInversionCofinanciadorActividadFinancieraRepository>(
    () => PerfilPreInversionCofinanciadorActividadFinancieraRepositoryImpl(
      perfilPreInversionCofinanciadorActividadFinancieraRemoteDataSource:
          locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<
      PerfilPreInversionCofinanciadorActividadFinancieraRepositoryDB>(
    () => PerfilPreInversionCofinanciadorActividadFinancieraRepositoryDBImpl(
      perfilPreInversionCofinanciadorActividadFinancieraLocalDataSource:
          locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<
      PerfilPreInversionCofinanciadorActividadFinancieraRemoteDataSource>(
    () =>
        PerfilPreInversionCofinanciadorActividadFinancieraRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<
      PerfilPreInversionCofinanciadorActividadFinancieraLocalDataSource>(
    () =>
        PerfilPreInversionCofinanciadorActividadFinancieraLocalDataSourceImpl(),
  );
}

perfilPreInversionCofinanciadorDesembolsoInit() {
  // bloc
  locator.registerFactory(() => PerfilPreInversionCofinanciadorDesembolsosBloc(
      perfilPreInversionCofinanciadorDesembolsoUsecaseDB: locator()));
  // cubit
  locator.registerFactory(() => PerfilPreInversionCofinanciadorDesembolsoCubit(
      perfilPreInversionCofinanciadorDesembolsoDB: locator()));

  // remote usecase
  locator.registerLazySingleton(
      () => PerfilPreInversionCofinanciadorDesembolsoUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(
      () => PerfilPreInversionCofinanciadorDesembolsoUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<
      PerfilPreInversionCofinanciadorDesembolsoRepository>(
    () => PerfilPreInversionCofinanciadorDesembolsoRepositoryImpl(
      perfilPreInversionCofinanciadorDesembolsoRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<
      PerfilPreInversionCofinanciadorDesembolsoRepositoryDB>(
    () => PerfilPreInversionCofinanciadorDesembolsoRepositoryDBImpl(
      perfilPreInversionCofinanciadorDesembolsoLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<
      PerfilPreInversionCofinanciadorDesembolsoRemoteDataSource>(
    () => PerfilPreInversionCofinanciadorDesembolsoRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<
      PerfilPreInversionCofinanciadorDesembolsoLocalDataSource>(
    () => PerfilPreInversionCofinanciadorDesembolsoLocalDataSourceImpl(),
  );
}

perfilPreInversionCofinanciadoresInit() {
  // bloc
  locator.registerFactory(() => PerfilPreInversionCofinanciadoresBloc(
      perfilPreInversionCofinanciadoresDB: locator()));

  // cubit
  locator.registerFactory(() => PerfilPreInversionCofinanciadorCubit(
      perfilPreInversionCofinanciadorDB: locator()));

  // remote usecase
  locator.registerLazySingleton(
      () => PerfilPreInversionCofinanciadorUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(
      () => PerfilPreInversionCofinanciadorUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<PerfilPreInversionCofinanciadorRepository>(
    () => PerfilPreInversionCofinanciadorRepositoryImpl(
      perfilPreInversionCofinanciadorRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<PerfilPreInversionCofinanciadorRepositoryDB>(
    () => PerfilPreInversionCofinanciadorRepositoryDBImpl(
      perfilPreInversionCofinanciadorLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator
      .registerLazySingleton<PerfilPreInversionCofinanciadorRemoteDataSource>(
    () => PerfilPreInversionCofinanciadorRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<PerfilPreInversionCofinanciadorLocalDataSource>(
    () => PerfilPreInversionCofinanciadorLocalDataSourceImpl(),
  );
}

perfilPreInversionCofinanciadorRubroInit() {
  // bloc
  locator.registerFactory(() => PerfilPreInversionCofinanciadorRubrosBloc(
      perfilPreInversionCofinanciadorRubroUsecaseDB: locator()));
  // cubit
  locator.registerFactory(() => PerfilPreInversionCofinanciadorRubroCubit(
      perfilPreInversionCofinanciadorRubroDB: locator()));

  // remote usecase
  locator.registerLazySingleton(
      () => PerfilPreInversionCofinanciadorRubroUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(
      () => PerfilPreInversionCofinanciadorRubroUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<PerfilPreInversionCofinanciadorRubroRepository>(
    () => PerfilPreInversionCofinanciadorRubroRepositoryImpl(
      perfilPreInversionCofinanciadorRubroRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator
      .registerLazySingleton<PerfilPreInversionCofinanciadorRubroRepositoryDB>(
    () => PerfilPreInversionCofinanciadorRubroRepositoryDBImpl(
      perfilPreInversionCofinanciadorRubroLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<
      PerfilPreInversionCofinanciadorRubroRemoteDataSource>(
    () => PerfilPreInversionCofinanciadorRubroRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<
      PerfilPreInversionCofinanciadorRubroLocalDataSource>(
    () => PerfilPreInversionCofinanciadorRubroLocalDataSourceImpl(),
  );
}

perfilPreInversionConsultoresInit() {
  // bloc
  locator.registerFactory(() => PerfilPreInversionConsultoresBloc(
      perfilPreInversionConsultoresDB: locator()));

  // cubit
  locator.registerFactory(() => PerfilPreInversionConsultorCubit(
      perfilPreInversionConsultorDB: locator()));

  // remote usecase
  locator.registerLazySingleton(
      () => PerfilPreInversionConsultorUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(
      () => PerfilPreInversionConsultorUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<PerfilPreInversionConsultorRepository>(
    () => PerfilPreInversionConsultorRepositoryImpl(
      perfilPreInversionConsultorRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<PerfilPreInversionConsultorRepositoryDB>(
    () => PerfilPreInversionConsultorRepositoryDBImpl(
      perfilPreInversionConsultorLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<PerfilPreInversionConsultorRemoteDataSource>(
    () => PerfilPreInversionConsultorRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<PerfilPreInversionConsultorLocalDataSource>(
    () => PerfilPreInversionConsultorLocalDataSourceImpl(),
  );
}

perfilPreInversionPreciosInit() {
  // bloc
  locator.registerFactory(() => PerfilesPreInversionesPreciosBloc(
      perfilPreInversionPrecioUsecaseDB: locator()));

  // cubit
  locator.registerFactory(() =>
      PerfilPreInversionPrecioCubit(perfilPreInversionPrecioDB: locator()));

  // remote usecase
  locator
      .registerLazySingleton(() => PerfilPreInversionPrecioUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(
      () => PerfilPreInversionPrecioUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<PerfilPreInversionPrecioRepository>(
    () => PerfilPreInversionPrecioRepositoryImpl(
      perfilPreInversionPrecioRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<PerfilPreInversionPrecioRepositoryDB>(
    () => PerfilPreInversionPrecioRepositoryDBImpl(
      perfilPreInversionPrecioLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<PerfilPreInversionPrecioRemoteDataSource>(
    () => PerfilPreInversionPrecioRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<PerfilPreInversionPrecioLocalDataSource>(
    () => PerfilPreInversionPrecioLocalDataSourceImpl(),
  );
}

perfilPreInversionPlanesNegociosInit() {
  // bloc
  locator.registerFactory(() => PerfilPreInversionPlanNegociosBloc(
      perfilPreInversionPlanNegocioUsecaseDB: locator()));

  // bloc
  locator.registerFactory(() => VPerfilesPreInversionesPlanNegociosCubit(
      vPerfilesPreInversionesPlanNegociosDB: locator()));

  // cubit
  locator.registerFactory(() => PerfilPreInversionCostosUPTCubit(
      perfilPreInversionPlanNegocioDB: locator()));

  // cubit
  locator.registerFactory(() => PerfilPreInversionIngresosUPTCubit(
      perfilPreInversionPlanNegocioDB: locator()));

  // remote usecase
  locator.registerLazySingleton(
      () => PerfilPreInversionPlanNegocioUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(
      () => PerfilPreInversionPlanNegocioUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<PerfilPreInversionPlanNegocioRepository>(
    () => PerfilPreInversionPlanNegocioRepositoryImpl(
      perfilPreInversionPlanNegocioRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<PerfilPreInversionPlanNegocioRepositoryDB>(
    () => PerfilPreInversionPlanNegocioRepositoryDBImpl(
      perfilPreInversionPlanNegocioLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<PerfilPreInversionPlanNegocioRemoteDataSource>(
    () => PerfilPreInversionPlanNegocioRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<PerfilPreInversionPlanNegocioLocalDataSource>(
    () => PerfilPreInversionPlanNegocioLocalDataSourceImpl(),
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

sitioEntregaInit() {
  // cubit
  locator.registerFactory(() => SitioEntregaCubit(sitioEntregaDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => SitioEntregaUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => SitioEntregaUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<SitioEntregaRepository>(
    () => SitioEntregaRepositoryImpl(
      sitioEntregaRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<SitioEntregaRepositoryDB>(
    () => SitioEntregaRepositoryDBImpl(
      sitioEntregaLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<SitioEntregaRemoteDataSource>(
    () => SitioEntregaRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<SitioEntregaLocalDataSource>(
    () => SitioEntregaLocalDataSourceImpl(),
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

tipoDiscapacidadInit() {
  // cubit
  locator.registerFactory(
      () => TipoDiscapacidadCubit(tipoDiscapacidadDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => TipoDiscapacidadUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => TipoDiscapacidadUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<TipoDiscapacidadRepository>(
    () => TipoDiscapacidadRepositoryImpl(
      tipoDiscapacidadRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<TipoDiscapacidadRepositoryDB>(
    () => TipoDiscapacidadRepositoryDBImpl(
      tipoDiscapacidadLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<TipoDiscapacidadRemoteDataSource>(
    () => TipoDiscapacidadRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<TipoDiscapacidadLocalDataSource>(
    () => TipoDiscapacidadLocalDataSourceImpl(),
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

beneficioInit() {
  // cubit
  locator.registerFactory(() => BeneficioCubit(beneficioDB: locator()));
  // remote usecase
  locator.registerLazySingleton(() => BeneficioUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => BeneficioUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<BeneficioRepository>(
    () => BeneficioRepositoryImpl(
      beneficioRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<BeneficioRepositoryDB>(
    () => BeneficioRepositoryDBImpl(
      beneficioLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<BeneficioRemoteDataSource>(
    () => BeneficioRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<BeneficioLocalDataSource>(
    () => BeneficioLocalDataSourceImpl(),
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

alianzaBeneficiarioInit() {
  // bloc
  locator.registerFactory(
      () => AlianzasBeneficiariosBloc(alianzaBeneficiarioUsecaseDB: locator()));

  // cubit
  locator.registerFactory(
      () => AlianzaBeneficiarioCubit(alianzaBeneficiarioDB: locator()));

  // remote usecase
  locator.registerLazySingleton(() => AlianzaBeneficiarioUsecase(locator()));

  // local usecase
  locator.registerLazySingleton(() => AlianzaBeneficiarioUsecaseDB(locator()));

  // repository
  locator.registerLazySingleton<AlianzaBeneficiarioRepository>(
    () => AlianzaBeneficiarioRepositoryImpl(
      alianzaBeneficiarioRemoteDataSource: locator(),
    ),
  );

  // repository DB
  locator.registerLazySingleton<AlianzaBeneficiarioRepositoryDB>(
    () => AlianzaBeneficiarioRepositoryDBImpl(
      alianzaBeneficiarioLocalDataSource: locator(),
    ),
  );

  // remote data source
  locator.registerLazySingleton<AlianzaBeneficiarioRemoteDataSource>(
    () => AlianzaBeneficiarioRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // local data source
  locator.registerLazySingleton<AlianzaBeneficiarioLocalDataSource>(
    () => AlianzaBeneficiarioLocalDataSourceImpl(),
  );
}

sliderInit() {
  // cubit
  locator.registerFactory(() => SliderCubit());
}
