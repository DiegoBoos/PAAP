import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/usuario_entity.dart';
import '../../usecases/actividad/actividad_exports.dart';
import '../../usecases/actividad_economica/actividad_economica_exports.dart';
import '../../usecases/actividad_financiera/actividad_financiera_exports.dart';
import '../../usecases/agrupacion/agrupacion_exports.dart';
import '../../usecases/aliado/aliado_exports.dart';
import '../../usecases/alianza/alianza_exports.dart';
import '../../usecases/alianza_beneficiario/alianza_beneficiario_exports.dart';
import '../../usecases/alianza_experiencia_agricola/alianza_experiencia_agricola_exports.dart';
import '../../usecases/alianza_experiencia_pecuaria/alianza_experiencia_pecuaria_exports.dart';
import '../../usecases/beneficiario/beneficiario_exports.dart';
import '../../usecases/cofinanciador/cofinanciador_exports.dart';
import '../../usecases/consultor/consultor_exports.dart';
import '../../usecases/convocatoria/convocatoria_exports.dart';
import '../../usecases/criterio/criterio_exports.dart';
import '../../usecases/departamento/departamento_exports.dart';
import '../../usecases/desembolso/desembolso_exports.dart';
import '../../usecases/estado_civil/estado_civil_exports.dart';
import '../../usecases/estado_visita/estado_visita_exports.dart';
import '../../usecases/evaluacion/evaluacion_exports.dart';
import '../../usecases/evaluacion_respuesta/evaluacion_respuesta_exports.dart';
import '../../usecases/experiencia_agricola/experiencia_agricola_exports.dart';
import '../../usecases/experiencia_pecuaria/experiencia_pecuaria_exports.dart';
import '../../usecases/frecuencia/frecuencia_exports.dart';
import '../../usecases/genero copy/genero_exports.dart';
import '../../usecases/grupo_especial/grupo_especial_exports.dart';
import '../../usecases/menu/menu_exports.dart';
import '../../usecases/municipio/municipio_exports.dart';
import '../../usecases/nivel_escolar/nivel_escolar_exports.dart';
import '../../usecases/opcion/opcion_exports.dart';
import '../../usecases/perfil/perfil_exports.dart';
import '../../usecases/perfil_beneficiario/perfil_beneficiario_exports.dart';
import '../../usecases/perfil_preinversion/perfil_preinversion_exports.dart';
import '../../usecases/perfil_preinversion_aliado/perfil_preinversion_aliado_exports.dart';
import '../../usecases/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_exports.dart';
import '../../usecases/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_exports.dart';
import '../../usecases/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_exports.dart';
import '../../usecases/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_exports.dart';
import '../../usecases/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_exports.dart';
import '../../usecases/perfil_preinversion_consultor/perfil_preinversion_consultor_exports.dart';
import '../../usecases/perfil_preinversion_plan_negocio/perfil_preinversion_plan_negocio_exports.dart';
import '../../usecases/perfil_preinversion_precio/perfil_preinversion_precio_exports.dart';
import '../../usecases/producto/producto_exports.dart';
import '../../usecases/proyecto/proyecto_exports.dart';
import '../../usecases/residencia/residencia_exports.dart';
import '../../usecases/revision/revision_exports.dart';
import '../../usecases/rubro/rubro_exports.dart';
import '../../usecases/sitio_entrega/sitio_entrega_exports.dart';
import '../../usecases/tipo_actividad_productiva/tipo_actividad_productiva_exports.dart';
import '../../usecases/tipo_calidad/tipo_calidad_exports.dart';
import '../../usecases/tipo_discapacidad/tipo_discapacidad_exports.dart';
import '../../usecases/tipo_entidad/tipo_entidad_exports.dart';
import '../../usecases/tipo_identificacion/tipo_identificacion_exports.dart';
import '../../usecases/tipo_movimiento/tipo_movimiento_exports.dart';
import '../../usecases/tipo_proyecto/tipo_proyecto_exports.dart';
import '../../usecases/tipo_tenencia/tipo_tenencia_exports.dart';
import '../../usecases/tipo_visita/tipo_visita_exports.dart';
import '../../usecases/unidad/unidad_exports.dart';
import '../../usecases/vereda/vereda_exports.dart';
import '../../usecases/visita/visita_exports.dart';

part 'sync_event.dart';
part 'sync_state.dart';

class SyncBloc extends Bloc<SyncEvent, SyncState> {
  final ActividadUsecase actividad;
  final ActividadUsecaseDB actividadDB;
  final ActividadEconomicaUsecase actividadEconomica;
  final ActividadEconomicaUsecaseDB actividadEconomicaDB;
  final ActividadFinancieraUsecase actividadFinanciera;
  final ActividadFinancieraUsecaseDB actividadFinancieraDB;
  final AgrupacionUsecase agrupacion;
  final AgrupacionUsecaseDB agrupacionDB;
  final AlianzaUsecase alianza;
  final AlianzaUsecaseDB alianzaDB;
  final CofinanciadorUsecase cofinanciador;
  final CofinanciadorUsecaseDB cofinanciadorDB;
  final ConsultorUsecase consultor;
  final ConsultorUsecaseDB consultorDB;
  final ConvocatoriaUsecase convocatoria;
  final ConvocatoriaUsecaseDB convocatoriaDB;
  final CriterioUsecase criterio;
  final CriterioUsecaseDB criterioDB;
  final DepartamentoUsecase departamento;
  final DepartamentoUsecaseDB departamentoDB;
  final DesembolsoUsecase desembolso;
  final DesembolsoUsecaseDB desembolsoDB;
  final EstadoCivilUsecase estadoCivil;
  final EstadoCivilUsecaseDB estadoCivilDB;
  final EstadoVisitaUsecase estadoVisita;
  final EstadoVisitaUsecaseDB estadoVisitaDB;
  final FrecuenciaUsecase frecuencia;
  final FrecuenciaUsecaseDB frecuenciaDB;
  final GeneroUsecase genero;
  final GeneroUsecaseDB generoDB;
  final GrupoEspecialUsecase grupoEspecial;
  final GrupoEspecialUsecaseDB grupoEspecialDB;
  final MenuUsecase menu;
  final MenuUsecaseDB menuDB;
  final MunicipioUsecase municipio;
  final MunicipioUsecaseDB municipioDB;
  final NivelEscolarUsecase nivelEscolar;
  final NivelEscolarUsecaseDB nivelEscolarDB;
  final OpcionUsecase opcion;
  final OpcionUsecaseDB opcionDB;
  final PerfilUsecase perfil;
  final PerfilUsecaseDB perfilDB;
  final ProductoUsecase producto;
  final ProductoUsecaseDB productoDB;
  final ProyectoUsecase proyecto;
  final ProyectoUsecaseDB proyectoDB;
  final ResidenciaUsecase residencia;
  final ResidenciaUsecaseDB residenciaDB;
  final RevisionUsecase revision;
  final RevisionUsecaseDB revisionDB;
  final SitioEntregaUsecase sitioEntrega;
  final SitioEntregaUsecaseDB sitioEntregaDB;
  final TipoActividadProductivaUsecase tipoActividadProductiva;
  final TipoActividadProductivaUsecaseDB tipoActividadProductivaDB;
  final TipoCalidadUsecase tipoCalidad;
  final TipoCalidadUsecaseDB tipoCalidadDB;
  final TipoDiscapacidadUsecase tipoDiscapacidad;
  final TipoDiscapacidadUsecaseDB tipoDiscapacidadDB;
  final TipoEntidadUsecase tipoEntidad;
  final TipoEntidadUsecaseDB tipoEntidadDB;
  final TipoIdentificacionUsecase tipoIdentificacion;
  final TipoIdentificacionUsecaseDB tipoIdentificacionDB;
  final TipoMovimientoUsecase tipoMovimiento;
  final TipoMovimientoUsecaseDB tipoMovimientoDB;
  final TipoProyectoUsecase tipoProyecto;
  final TipoProyectoUsecaseDB tipoProyectoDB;
  final TipoTenenciaUsecase tipoTenencia;
  final TipoTenenciaUsecaseDB tipoTenenciaDB;
  final TipoVisitaUsecase tipoVisita;
  final TipoVisitaUsecaseDB tipoVisitaDB;
  final UnidadUsecase unidad;
  final UnidadUsecaseDB unidadDB;
  final VeredaUsecase vereda;
  final VeredaUsecaseDB veredaDB;
  final PerfilPreInversionUsecase perfilPreInversion;
  final PerfilPreInversionUsecaseDB perfilPreInversionDB;
  final RubroUsecase rubro;
  final RubroUsecaseDB rubroDB;

  final AliadoUsecase aliado;
  final AliadoUsecaseDB aliadoDB;
  final AlianzaBeneficiarioUsecase alianzaBeneficiario;
  final AlianzaBeneficiarioUsecaseDB alianzaBeneficiarioDB;
  final AlianzaExperienciaAgricolaUsecase alianzaExperienciaAgricola;
  final AlianzaExperienciaAgricolaUsecaseDB alianzaExperienciaAgricolaDB;
  final AlianzaExperienciaPecuariaUsecase alianzaExperienciaPecuaria;
  final AlianzaExperienciaPecuariaUsecaseDB alianzaExperienciaPecuariaDB;
  final BeneficiarioUsecase beneficiario;
  final BeneficiarioUsecaseDB beneficiarioDB;
  final EvaluacionUsecase evaluacion;
  final EvaluacionUsecaseDB evaluacionDB;
  final EvaluacionRespuestaUsecase evaluacionRespuesta;
  final EvaluacionRespuestaUsecaseDB evaluacionRespuestaDB;
  final ExperienciaAgricolaUsecase experienciaAgricola;
  final ExperienciaAgricolaUsecaseDB experienciaAgricolaDB;
  final ExperienciaPecuariaUsecase experienciaPecuaria;
  final ExperienciaPecuariaUsecaseDB experienciaPecuariaDB;
  final PerfilBeneficiarioUsecase perfilBeneficiario;
  final PerfilBeneficiarioUsecaseDB perfilBeneficiarioDB;
  final PerfilPreInversionAliadoUsecase perfilPreInversionAliado;
  final PerfilPreInversionAliadoUsecaseDB perfilPreInversionAliadoDB;
  final PerfilPreInversionBeneficiarioUsecase perfilPreInversionBeneficiario;
  final PerfilPreInversionBeneficiarioUsecaseDB
      perfilPreInversionBeneficiarioDB;
  final PerfilPreInversionCofinanciadorUsecase perfilPreInversionCofinanciador;
  final PerfilPreInversionCofinanciadorUsecaseDB
      perfilPreInversionCofinanciadorDB;
  final PerfilPreInversionCofinanciadorActividadFinancieraUsecase
      perfilPreInversionCofinanciadorActividadFinanciera;
  final PerfilPreInversionCofinanciadorActividadFinancieraUsecaseDB
      perfilPreInversionCofinanciadorActividadFinancieraDB;
  final PerfilPreInversionCofinanciadorDesembolsoUsecase
      perfilPreInversionCofinanciadorDesembolso;
  final PerfilPreInversionCofinanciadorDesembolsoUsecaseDB
      perfilPreInversionCofinanciadorDesembolsoDB;
  final PerfilPreInversionCofinanciadorRubroUsecase
      perfilPreInversionCofinanciadorRubro;
  final PerfilPreInversionCofinanciadorRubroUsecaseDB
      perfilPreInversionCofinanciadorRubroDB;
  final PerfilPreInversionConsultorUsecase perfilPreInversionConsultor;
  final PerfilPreInversionConsultorUsecaseDB perfilPreInversionConsultorDB;
  final PerfilPreInversionPlanNegocioUsecase perfilPreInversionPlanNegocio;
  final PerfilPreInversionPlanNegocioUsecaseDB perfilPreInversionPlanNegocioDB;
  final PerfilPreInversionPrecioUsecase perfilPreInversionPrecio;
  final PerfilPreInversionPrecioUsecaseDB perfilPreInversionPrecioDB;
  final VisitaUsecase visita;
  final VisitaUsecaseDB visitaDB;

  int gTotal = 0;

  SyncBloc({
    required this.actividad,
    required this.actividadDB,
    required this.actividadEconomica,
    required this.actividadEconomicaDB,
    required this.actividadFinanciera,
    required this.actividadFinancieraDB,
    required this.agrupacion,
    required this.agrupacionDB,
    required this.alianza,
    required this.alianzaDB,
    required this.cofinanciador,
    required this.cofinanciadorDB,
    required this.consultor,
    required this.consultorDB,
    required this.convocatoria,
    required this.convocatoriaDB,
    required this.criterio,
    required this.criterioDB,
    required this.departamento,
    required this.departamentoDB,
    required this.desembolso,
    required this.desembolsoDB,
    required this.estadoCivil,
    required this.estadoCivilDB,
    required this.estadoVisita,
    required this.estadoVisitaDB,
    required this.frecuencia,
    required this.frecuenciaDB,
    required this.genero,
    required this.generoDB,
    required this.grupoEspecial,
    required this.grupoEspecialDB,
    required this.menu,
    required this.menuDB,
    required this.municipio,
    required this.municipioDB,
    required this.nivelEscolar,
    required this.nivelEscolarDB,
    required this.opcion,
    required this.opcionDB,
    required this.perfil,
    required this.perfilDB,
    required this.producto,
    required this.productoDB,
    required this.proyecto,
    required this.proyectoDB,
    required this.residencia,
    required this.residenciaDB,
    required this.revision,
    required this.revisionDB,
    required this.sitioEntrega,
    required this.sitioEntregaDB,
    required this.tipoCalidad,
    required this.tipoCalidadDB,
    required this.tipoActividadProductiva,
    required this.tipoActividadProductivaDB,
    required this.tipoDiscapacidad,
    required this.tipoDiscapacidadDB,
    required this.tipoEntidad,
    required this.tipoEntidadDB,
    required this.tipoIdentificacion,
    required this.tipoIdentificacionDB,
    required this.tipoMovimiento,
    required this.tipoMovimientoDB,
    required this.tipoProyecto,
    required this.tipoProyectoDB,
    required this.tipoTenencia,
    required this.tipoTenenciaDB,
    required this.tipoVisita,
    required this.tipoVisitaDB,
    required this.unidad,
    required this.unidadDB,
    required this.vereda,
    required this.veredaDB,
    required this.perfilPreInversion,
    required this.perfilPreInversionDB,
    required this.rubro,
    required this.rubroDB,
    required this.aliado,
    required this.aliadoDB,
    required this.alianzaBeneficiario,
    required this.alianzaBeneficiarioDB,
    required this.alianzaExperienciaAgricola,
    required this.alianzaExperienciaAgricolaDB,
    required this.alianzaExperienciaPecuaria,
    required this.alianzaExperienciaPecuariaDB,
    required this.beneficiario,
    required this.beneficiarioDB,
    required this.evaluacion,
    required this.evaluacionDB,
    required this.evaluacionRespuesta,
    required this.evaluacionRespuestaDB,
    required this.experienciaAgricola,
    required this.experienciaAgricolaDB,
    required this.experienciaPecuaria,
    required this.experienciaPecuariaDB,
    required this.perfilBeneficiario,
    required this.perfilBeneficiarioDB,
    required this.perfilPreInversionAliado,
    required this.perfilPreInversionAliadoDB,
    required this.perfilPreInversionBeneficiario,
    required this.perfilPreInversionBeneficiarioDB,
    required this.perfilPreInversionCofinanciador,
    required this.perfilPreInversionCofinanciadorDB,
    required this.perfilPreInversionCofinanciadorActividadFinanciera,
    required this.perfilPreInversionCofinanciadorActividadFinancieraDB,
    required this.perfilPreInversionCofinanciadorDesembolso,
    required this.perfilPreInversionCofinanciadorDesembolsoDB,
    required this.perfilPreInversionCofinanciadorRubro,
    required this.perfilPreInversionCofinanciadorRubroDB,
    required this.perfilPreInversionConsultor,
    required this.perfilPreInversionConsultorDB,
    required this.perfilPreInversionPlanNegocio,
    required this.perfilPreInversionPlanNegocioDB,
    required this.perfilPreInversionPrecio,
    required this.perfilPreInversionPrecioDB,
    required this.visita,
    required this.visitaDB,
  }) : super(SyncInitial()) {
    on<SyncStarted>((event, emit) async {
      final usuario = event.usuario;
      if (event.mode == 'A') {
        gTotal = 59;
        add(SyncStatusChanged(state.syncProgressModel!.copyWith(
            title: 'Sincronizando Actividades',
            counter: state.syncProgressModel!.counter + 1,
            total: gTotal,
            percent: calculatePercent())));
        await syncActividades(usuario, emit);
      } else {
        gTotal = 20;
        add(SyncStatusChanged(state.syncProgressModel!.copyWith(
            title: 'Sincronizando Aliados',
            counter: state.syncProgressModel!.counter + 1,
            total: gTotal,
            percent: calculatePercent())));
        await uploadAliado(usuario, emit);
      }
    });
    on<SyncStatusChanged>((event, emit) {
      event.progress.counter == gTotal + 1
          ? emit(SyncSuccess())
          : emit(SyncInProgress(event.progress));
    });
    on<SyncError>((event, emit) => emit(SyncFailure(event.message)));
  }

  double calculatePercent() {
    final counter = state.syncProgressModel!.counter;
    final total = gTotal;
    final percent = ((counter / total) * 100) / 100;

    return percent;
  }

  // Sync Actividades
  Future<void> syncActividades(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Actividades',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await actividad.getActividadesUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveActividades(data, emit, usuario));
  }

  Future<void> saveActividades(List<ActividadEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result = await actividadDB.saveActividadesUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncActividadesEconomicas(usuario, emit));
  }

  // Sync ActividadesEconomicas
  Future<void> syncActividadesEconomicas(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Actividades Económicas',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result =
        await actividadEconomica.getActividadesEconomicasUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveActividadesEconomicas(data, emit, usuario));
  }

  Future<void> saveActividadesEconomicas(List<ActividadEconomicaEntity> data,
      Emitter<SyncState> emit, usuario) async {
    final result =
        await actividadEconomicaDB.saveActividadesEconomicasUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncActividadesFinancieras(usuario, emit));
  }

  // Sync Actividades Financieras
  Future<void> syncActividadesFinancieras(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Actividades Financieras',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result =
        await actividadFinanciera.getActividadesFinancierasUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveActividadesFinancieras(data, emit, usuario));
  }

  Future<void> saveActividadesFinancieras(List<ActividadFinancieraEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result =
        await actividadFinancieraDB.saveActividadesFinancierasUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncAgrupaciones(usuario, emit));
  }

  // Sync Agrupaciones
  Future<void> syncAgrupaciones(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Agrupaciones',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await agrupacion.getAgrupacionesUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveAgrupaciones(data, emit, usuario));
  }

  Future<void> saveAgrupaciones(List<AgrupacionEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result = await agrupacionDB.saveAgrupacionesUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncAlianzas(usuario, emit));
  }

  // Sync Alianzas
  Future<void> syncAlianzas(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Alianzas',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await alianza.getAlianzasUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveAlianzas(data, emit, usuario));
  }

  Future<void> saveAlianzas(List<AlianzaEntity> data, Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result = await alianzaDB.saveAlianzasUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncCofinanciadores(usuario, emit));
  }

  // Sync Cofinanciadores
  Future<void> syncCofinanciadores(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Cofinanciadores',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result =
        await cofinanciador.getCofinanciadoresByDepartamentoUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveCofinanciadores(data, emit, usuario));
  }

  Future<void> saveCofinanciadores(List<CofinanciadorEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result = await cofinanciadorDB.saveCofinanciadoresUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncConsultores(usuario, emit));
  }

  // Sync Consultores
  Future<void> syncConsultores(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Consultores',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await consultor.getConsultoresUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveConsultores(data, emit, usuario));
  }

  Future<void> saveConsultores(List<ConsultorEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result = await consultorDB.saveConsultoresUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncConvocatorias(usuario, emit));
  }

  // Sync Convocatorias
  Future<void> syncConvocatorias(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Convocatorias',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await convocatoria.getConvocatoriasUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveConvocatorias(data, emit, usuario));
  }

  Future<void> saveConvocatorias(List<ConvocatoriaEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result = await convocatoriaDB.saveConvocatoriaUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncCriterios(usuario, emit));
  }

  // Sync Criterios
  Future<void> syncCriterios(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Criterios',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await criterio.getCriteriosUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveCriterios(data, emit, usuario));
  }

  Future<void> saveCriterios(List<CriterioEntity> data, Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result = await criterioDB.saveCriteriosUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncDepartamentos(usuario, emit));
  }

  // Sync Departamentos
  Future<void> syncDepartamentos(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Departamentos',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await departamento.getDepartamentosUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveDepartamentos(data, emit, usuario));
  }

  Future<void> saveDepartamentos(List<DepartamentoEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result = await departamentoDB.saveDepartamentosUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncDesembolsos(usuario, emit));
  }

  // Sync Desembolsos
  Future<void> syncDesembolsos(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Desembolsos',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await desembolso.getDesembolsosUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveDesembolsos(data, emit, usuario));
  }

  Future<void> saveDesembolsos(List<DesembolsoEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result = await desembolsoDB.saveDesembolsosUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncEstadosCiviles(usuario, emit));
  }

  // Sync Estado Civil
  Future<void> syncEstadosCiviles(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Estados Civiles',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await estadoCivil.getEstadosCivilesUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveEstadosCiviles(data, emit, usuario));
  }

  Future<void> saveEstadosCiviles(List<EstadoCivilEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result = await estadoCivilDB.saveEstadosCivilesUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncEstadosVisitas(usuario, emit));
  }

  // Sync Estado Visita
  Future<void> syncEstadosVisitas(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Estados Visitas',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await estadoVisita.getEstadosVisitasUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveEstadosVisitas(data, emit, usuario));
  }

  Future<void> saveEstadosVisitas(List<EstadoVisitaEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result = await estadoVisitaDB.saveEstadosVisitasUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncFrecuencias(usuario, emit));
  }

  // Sync Frecuencia
  Future<void> syncFrecuencias(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Estados Frecuencias',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await frecuencia.getFrecuenciasUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveFrecuencias(data, emit, usuario));
  }

  Future<void> saveFrecuencias(List<FrecuenciaEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result = await frecuenciaDB.saveFrecuenciasUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncGeneros(usuario, emit));
  }

  // Sync Generos
  Future<void> syncGeneros(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Estados Generos',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await genero.getGenerosUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveGeneros(data, emit, usuario));
  }

  Future<void> saveGeneros(List<GeneroEntity> data, Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result = await generoDB.saveGenerosUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncGruposEspeciales(usuario, emit));
  }

  // Sync Grupos Especiales
  Future<void> syncGruposEspeciales(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Estados Grupos Especiales',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await grupoEspecial.getGruposEspecialesUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveGruposEspeciales(data, emit, usuario));
  }

  Future<void> saveGruposEspeciales(List<GrupoEspecialEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result = await grupoEspecialDB.saveGrupoEspecialUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncMenus(usuario, emit));
  }

  // Sync Menu
  Future<void> syncMenus(UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Menus',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await menu.getMenuUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveMenus(data, emit, usuario));
  }

  Future<void> saveMenus(List<MenuEntity> data, Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result = await menuDB.saveMenuUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncMunicipios(usuario, emit));
  }

  // Sync Municipio
  Future<void> syncMunicipios(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Municipios',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await municipio.getMunicipiosUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveMunicipios(data, emit, usuario));
  }

  Future<void> saveMunicipios(List<MunicipioEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result = await municipioDB.saveMunicipiosUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncNivelesEscolares(usuario, emit));
  }

  // Sync Niveles Escolares
  Future<void> syncNivelesEscolares(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Niveles Escolares',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await nivelEscolar.getNivelesEscolaresUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveNivelesEscolares(data, emit, usuario));
  }

  Future<void> saveNivelesEscolares(List<NivelEscolarEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result = await nivelEscolarDB.saveNivelesEscolaresUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncOpciones(usuario, emit));
  }

  // Sync Opciones
  Future<void> syncOpciones(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Opciones',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await opcion.getOpcionesUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveOpciones(data, emit, usuario));
  }

  Future<void> saveOpciones(List<OpcionEntity> data, Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result = await opcionDB.saveOpcionesUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncPerfiles(usuario, emit));
  }

  // Sync Perfiles
  Future<void> syncPerfiles(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Perfiles',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await perfil.getPerfilesUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await savePerfiles(data, emit, usuario));
  }

  Future<void> savePerfiles(List<PerfilEntity> data, Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result = await perfilDB.savePerfilesUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncProductos(usuario, emit));
  }

  // Sync Productos
  Future<void> syncProductos(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Productos',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await producto.getProductosUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveProductos(data, emit, usuario));
  }

  Future<void> saveProductos(List<ProductoEntity> data, Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result = await productoDB.saveProductoUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncProyectos(usuario, emit));
  }

  // Sync Proyectos
  Future<void> syncProyectos(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Proyectos',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await proyecto.getProyectosUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveProyectos(data, emit, usuario));
  }

  Future<void> saveProyectos(List<ProyectoEntity> data, Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result = await proyectoDB.saveProyectosUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncResidencias(usuario, emit));
  }

  // Sync Residencias
  Future<void> syncResidencias(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Residencias',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await residencia.getResidenciasUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveResidencias(data, emit, usuario));
  }

  Future<void> saveResidencias(List<ResidenciaEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result = await residenciaDB.saveResidenciasUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncRevisiones(usuario, emit));
  }

  // Sync Revisiones
  Future<void> syncRevisiones(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Revisiones',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await revision.getRevisionesUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveRevisiones(data, emit, usuario));
  }

  Future<void> saveRevisiones(List<RevisionEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result = await revisionDB.saveRevisionesUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncSitiosEntregas(usuario, emit));
  }

  // Sync Sitios Entregas
  Future<void> syncSitiosEntregas(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Sitios Entregas',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await sitioEntrega.getSitiosEntregasUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveSitiosEntregas(data, emit, usuario));
  }

  Future<void> saveSitiosEntregas(List<SitioEntregaEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result = await sitioEntregaDB.saveSitiosEntregasUsecaseDB(data);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (_) async =>
            await syncSitiosTiposActividadesProductivas(usuario, emit));
  }

  // Sync Sitios Tipos Actividades Productivas
  Future<void> syncSitiosTiposActividadesProductivas(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Sitios Tipos Actividades Productivas',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await tipoActividadProductiva
        .getTiposActividadesProductivasUsecase(usuario);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await saveSitiosTiposActividadesProductivas(data, emit, usuario));
  }

  Future<void> saveSitiosTiposActividadesProductivas(
      List<TipoActividadProductivaEntity> data,
      Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result = await tipoActividadProductivaDB
        .saveTiposActividadesProductivasUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncSitiosTiposCalidades(usuario, emit));
  }

  // Sync Sitios Tipos Calidades
  Future<void> syncSitiosTiposCalidades(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Sitios Tipos Actividades Productivas',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await tipoCalidad.getTiposCalidadesUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveSitiosTiposCalidades(data, emit, usuario));
  }

  Future<void> saveSitiosTiposCalidades(List<TipoCalidadEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result = await tipoCalidadDB.saveTiposCalidadesUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncTiposDiscapacidades(usuario, emit));
  }

  // Sync Sitios Tipos Discapacidades
  Future<void> syncTiposDiscapacidades(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Tipos Discapacidades',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result =
        await tipoDiscapacidad.getTiposDiscapacidadesUsecase(usuario);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await saveSitiosTiposDiscapacidades(data, emit, usuario));
  }

  Future<void> saveSitiosTiposDiscapacidades(List<TipoDiscapacidadEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result =
        await tipoDiscapacidadDB.saveTiposDiscapacidadesUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncTiposEntidades(usuario, emit));
  }

  // Sync Sitios Tipos Entidades
  Future<void> syncTiposEntidades(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Tipos Entidades',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await tipoEntidad.getTiposEntidadesUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveSitiosTiposEntidades(data, emit, usuario));
  }

  Future<void> saveSitiosTiposEntidades(List<TipoEntidadEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result = await tipoEntidadDB.saveTiposEntidadesUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncTiposIdentificaciones(usuario, emit));
  }

  // Sync Sitios Tipos Identificaciones
  Future<void> syncTiposIdentificaciones(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Tipos Identificaciones',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result =
        await tipoIdentificacion.getTiposIdentificacionesUsecase(usuario);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await saveSitiosTiposIdentificaciones(data, emit, usuario));
  }

  Future<void> saveSitiosTiposIdentificaciones(
      List<TipoIdentificacionEntity> data,
      Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result =
        await tipoIdentificacionDB.saveTiposIdentificacionesUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncTiposMovimientos(usuario, emit));
  }

  // Sync Sitios Tipos Movimientos
  Future<void> syncTiposMovimientos(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Tipos Movimientos',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await tipoMovimiento.getTiposMovimientosUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveSitiosTiposMovimientos(data, emit, usuario));
  }

  Future<void> saveSitiosTiposMovimientos(List<TipoMovimientoEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result = await tipoMovimientoDB.saveTiposMovimientosUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncTiposProyectos(usuario, emit));
  }

  // Sync Sitios Tipos Proyectos
  Future<void> syncTiposProyectos(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Tipos Proyectos',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await tipoProyecto.getTiposProyectosUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveSitiosTiposProyectos(data, emit, usuario));
  }

  Future<void> saveSitiosTiposProyectos(List<TipoProyectoEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result = await tipoProyectoDB.saveTiposProyectosUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncTiposTenencias(usuario, emit));
  }

  // Sync Sitios Tipos Tenencias
  Future<void> syncTiposTenencias(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Tipos Tenencias',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await tipoTenencia.getTiposTenenciasUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveSitiosTiposTenencias(data, emit, usuario));
  }

  Future<void> saveSitiosTiposTenencias(List<TipoTenenciaEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result = await tipoTenenciaDB.saveTiposTenenciasUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncTiposVisitas(usuario, emit));
  }

  // Sync Tipos Visitas
  Future<void> syncTiposVisitas(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Tipos Visitas',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await tipoVisita.getTiposVisitasUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveSitiosTiposVisitas(data, emit, usuario));
  }

  Future<void> saveSitiosTiposVisitas(List<TipoVisitaEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result = await tipoVisitaDB.saveTiposVisitasUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncUnidades(usuario, emit));
  }

  // Sync Unidades
  Future<void> syncUnidades(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Unidades',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await unidad.getUnidadesUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveSitiosUnidades(data, emit, usuario));
  }

  Future<void> saveSitiosUnidades(List<UnidadEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result = await unidadDB.saveUnidadesUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncVeredas(usuario, emit));
  }

  // Sync Veredas
  Future<void> syncVeredas(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Veredas',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await vereda.getVeredasUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveVeredas(data, emit, usuario));
  }

  Future<void> saveVeredas(List<VeredaEntity> data, Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result = await veredaDB.saveVeredasUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncPerfilesPreInversion(usuario, emit));
  }

  // Sync Perfiles PreInversion
  Future<void> syncPerfilesPreInversion(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando PerfilesPreInversion',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result =
        await perfilPreInversion.getPerfilesPreInversionUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await savePerfilesPreInversion(data, emit, usuario));
  }

  Future<void> savePerfilesPreInversion(List<PerfilPreInversionEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result =
        await perfilPreInversionDB.savePerfilesPreInversionUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await syncRubros(usuario, emit));
  }

  // Sync Rubros
  Future<void> syncRubros(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Rubros',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await rubro.getRubrosUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveRubros(data, emit, usuario));
  }

  Future<void> saveRubros(List<RubroEntity> data, Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result = await rubroDB.saveRubrosUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await uploadAliado(usuario, emit));
  }

  // Sync Aliados
  Future<void> uploadAliado(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Aliados',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await aliadoDB.getAliadosProduccionUsecaseDB();
    result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveAliadosRemote(usuario, data, emit));
  }

  Future<void> saveAliadosRemote(UsuarioEntity usuario, List<AliadoEntity> data,
      Emitter<SyncState> emit) async {
    final result = await aliado.saveAliadosUsecase(usuario, data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await updateAliadosProduccion(usuario, data, emit));
  }

  Future<void> updateAliadosProduccion(UsuarioEntity usuario,
      List<AliadoEntity> data, Emitter<SyncState> emit) async {
    final result = await aliadoDB.updateAliadosProduccionUsecaseDB(data);
    result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await syncAliados(usuario, emit, data));
  }

  Future<void> syncAliados(
      UsuarioEntity usuario, Emitter<SyncState> emit, int result) async {
    if (result == 0) {
      final result = await aliado.getAliadosUsecase(usuario);
      return result.fold((failure) => add(SyncError(failure.properties.first)),
          (data) async => await saveSyncAliados(data, emit, usuario));
    } else {
      await uploadAlianzaBeneficiario(usuario, emit);
    }
  }

  Future<void> saveSyncAliados(List<AliadoEntity> data, Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result = await aliadoDB.saveAliadosUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await uploadAlianzaBeneficiario(usuario, emit));
  }

  // Sync Alianza Beneficiario
  Future<void> uploadAlianzaBeneficiario(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Alianzas Beneficiarios',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await alianzaBeneficiarioDB
        .getAlianzasBeneficiariosProduccionUsecaseDB();
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await saveAlianzasBeneficiariosRemote(usuario, data, emit));
  }

  Future<void> saveAlianzasBeneficiariosRemote(UsuarioEntity usuario,
      List<AlianzaBeneficiarioEntity> data, Emitter<SyncState> emit) async {
    final result = await alianzaBeneficiario.saveAlianzasBeneficiariosUsecase(
        usuario, data);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await updateAlianzasBeneficiariosProduccion(usuario, data, emit));
  }

  Future<void> updateAlianzasBeneficiariosProduccion(UsuarioEntity usuario,
      List<AlianzaBeneficiarioEntity> data, Emitter<SyncState> emit) async {
    final result = await alianzaBeneficiarioDB
        .updateAlianzasBeneficiariosProduccionUsecaseDB(data);
    result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await syncAlianzasBeneficiarios(usuario, emit, data));
  }

  Future<void> syncAlianzasBeneficiarios(
      UsuarioEntity usuario, Emitter<SyncState> emit, int result) async {
    if (result == 0) {
      final result =
          await alianzaBeneficiario.getAlianzasBeneficiariosUsecase(usuario);
      return result.fold(
          (failure) => add(SyncError(failure.properties.first)),
          (data) async =>
              await saveSyncAlianzasBeneficiarios(data, emit, usuario));
    } else {
      await uploadAlianzaExperienciaAgricola(usuario, emit);
    }
  }

  Future<void> saveSyncAlianzasBeneficiarios(
      List<AlianzaBeneficiarioEntity> data,
      Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result =
        await alianzaBeneficiarioDB.saveAlianzasBeneficiariosUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await uploadAlianzaExperienciaAgricola(usuario, emit));
  }

  // Sync Alianza ExperienciaAgricola
  Future<void> uploadAlianzaExperienciaAgricola(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Alianzas Experiencias Agricolas',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await alianzaExperienciaAgricolaDB
        .getAlianzasExperienciasAgricolasProduccionUsecaseDB();
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await saveAlianzasExperienciasAgricolasRemote(usuario, data, emit));
  }

  Future<void> saveAlianzasExperienciasAgricolasRemote(
      UsuarioEntity usuario,
      List<AlianzaExperienciaAgricolaEntity> data,
      Emitter<SyncState> emit) async {
    final result = await alianzaExperienciaAgricola
        .saveAlianzasExperienciasAgricolasUsecase(usuario, data);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async => await updateAlianzasExperienciasAgricolasProduccion(
            usuario, data, emit));
  }

  Future<void> updateAlianzasExperienciasAgricolasProduccion(
      UsuarioEntity usuario,
      List<AlianzaExperienciaAgricolaEntity> data,
      Emitter<SyncState> emit) async {
    final result = await alianzaExperienciaAgricolaDB
        .updateAlianzasExperienciasAgricolasProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await syncAlianzasExperienciasAgricolas(usuario, emit, data));
  }

  Future<void> syncAlianzasExperienciasAgricolas(
      UsuarioEntity usuario, Emitter<SyncState> emit, int result) async {
    if (result == 0) {
      final result = await alianzaExperienciaAgricola
          .getAlianzasExperienciasAgricolasUsecase(usuario);
      return result.fold(
          (failure) => add(SyncError(failure.properties.first)),
          (data) async =>
              await saveSyncAlianzasExperienciasAgricolas(data, emit, usuario));
    } else {
      await uploadAlianzaExperienciaPecuaria(usuario, emit);
    }
  }

  Future<void> saveSyncAlianzasExperienciasAgricolas(
      List<AlianzaExperienciaAgricolaEntity> data,
      Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result = await alianzaExperienciaAgricolaDB
        .saveAlianzasExperienciasAgricolasUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await uploadAlianzaExperienciaPecuaria(usuario, emit));
  }

  // Sync Alianza ExperienciaPecuaria
  Future<void> uploadAlianzaExperienciaPecuaria(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Alianzas Experiencias Pecuarias',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await alianzaExperienciaPecuariaDB
        .getAlianzasExperienciasPecuariasProduccionUsecaseDB();
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await saveAlianzasExperienciasPecuariasRemote(usuario, data, emit));
  }

  Future<void> saveAlianzasExperienciasPecuariasRemote(
      UsuarioEntity usuario,
      List<AlianzaExperienciaPecuariaEntity> data,
      Emitter<SyncState> emit) async {
    final result = await alianzaExperienciaPecuaria
        .saveAlianzasExperienciasPecuariasUsecase(usuario, data);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async => await updateAlianzasExperienciasPecuariasProduccion(
            usuario, data, emit));
  }

  Future<void> updateAlianzasExperienciasPecuariasProduccion(
      UsuarioEntity usuario,
      List<AlianzaExperienciaPecuariaEntity> data,
      Emitter<SyncState> emit) async {
    final result = await alianzaExperienciaPecuariaDB
        .updateAlianzasExperienciasPecuariasProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await syncAlianzasExperienciasPecuarias(usuario, emit, data));
  }

  Future<void> syncAlianzasExperienciasPecuarias(
      UsuarioEntity usuario, Emitter<SyncState> emit, int result) async {
    if (result == 0) {
      final result = await alianzaExperienciaPecuaria
          .getAlianzasExperienciasPecuariasUsecase(usuario);
      return result.fold(
          (failure) => add(SyncError(failure.properties.first)),
          (data) async =>
              await saveSyncAlianzasExperienciasPecuarias(data, emit, usuario));
    } else {
      await uploadBeneficiario(usuario, emit);
    }
  }

  Future<void> saveSyncAlianzasExperienciasPecuarias(
      List<AlianzaExperienciaPecuariaEntity> data,
      Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result = await alianzaExperienciaPecuariaDB
        .saveAlianzasExperienciasPecuariasUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await uploadBeneficiario(usuario, emit));
  }

  // Sync Beneficiarios
  Future<void> uploadBeneficiario(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Beneficiarios',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await beneficiarioDB.getBeneficiariosProduccionUsecaseDB();
    result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveBeneficiariosRemote(usuario, data, emit));
  }

  Future<void> saveBeneficiariosRemote(UsuarioEntity usuario,
      List<BeneficiarioEntity> data, Emitter<SyncState> emit) async {
    final result = await beneficiario.saveBeneficiariosUsecase(usuario, data);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await updateBeneficiariosProduccion(usuario, data, emit));
  }

  Future<void> updateBeneficiariosProduccion(UsuarioEntity usuario,
      List<BeneficiarioEntity> data, Emitter<SyncState> emit) async {
    final result =
        await beneficiarioDB.updateBeneficiariosProduccionUsecaseDB(data);
    result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await syncBeneficiarios(usuario, emit, data));
  }

  Future<void> syncBeneficiarios(
      UsuarioEntity usuario, Emitter<SyncState> emit, int result) async {
    if (result == 0) {
      final result = await beneficiario.getBeneficiariosUsecase(usuario);
      return result.fold((failure) => add(SyncError(failure.properties.first)),
          (data) async => await saveSyncBeneficiarios(data, emit, usuario));
    } else {
      await uploadEvaluacion(usuario, emit);
    }
  }

  Future<void> saveSyncBeneficiarios(List<BeneficiarioEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result = await beneficiarioDB.saveBeneficiariosUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => uploadEvaluacion(usuario, emit));
  }

  // Sync Evaluaciones
  Future<void> uploadEvaluacion(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Evaluaciones',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await evaluacionDB.getEvaluacionesProduccionUsecaseDB();
    result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveEvaluacionesRemote(usuario, data, emit));
  }

  Future<void> saveEvaluacionesRemote(UsuarioEntity usuario,
      List<EvaluacionEntity> data, Emitter<SyncState> emit) async {
    final result = await evaluacion.saveEvaluacionesUsecase(usuario, data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async {
      await evaluacionRespuestaDB
          .updateRespuestaRemoteEvaluacionIdUsecaseDB(data);
      await downloadEvaluaciones(usuario, emit);
    });
  }

  Future<void> downloadEvaluaciones(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    final result = await evaluacion.getEvaluacionesUsecase(usuario);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveDownloadEvaluaciones(data, emit, usuario));
  }

  Future<void> saveDownloadEvaluaciones(List<EvaluacionEntity> data,
      Emitter<SyncState> emit, UsuarioEntity usuario) async {
    final result = await evaluacionDB.saveEvaluacionesUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await uploadEvaluacionRespuesta(usuario, emit));
  }

  // Sync EvaluacionesRespuestas
  Future<void> uploadEvaluacionRespuesta(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Evaluaciones Respuestas',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await evaluacionRespuestaDB
        .getEvaluacionesRespuestasProduccionUsecaseDB();
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await saveEvaluacionesRespuestasRemote(usuario, data, emit));
  }

  Future<void> saveEvaluacionesRespuestasRemote(UsuarioEntity usuario,
      List<EvaluacionRespuestaEntity> data, Emitter<SyncState> emit) async {
    final result = await evaluacionRespuesta.saveEvaluacionesRespuestasUsecase(
        usuario, data);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await updateEvaluacionesRespuestasProduccion(usuario, data, emit));
  }

  Future<void> updateEvaluacionesRespuestasProduccion(UsuarioEntity usuario,
      List<EvaluacionRespuestaEntity> data, Emitter<SyncState> emit) async {
    final result = await evaluacionRespuestaDB
        .updateEvaluacionesRespuestasProduccionUsecaseDB(data);
    result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await syncEvaluacionesRespuestas(usuario, emit, data));
  }

  Future<void> syncEvaluacionesRespuestas(
      UsuarioEntity usuario, Emitter<SyncState> emit, int result) async {
    if (result == 0) {
      final result =
          await evaluacionRespuesta.getEvaluacionesRespuestasUsecase(usuario);
      return result.fold(
          (failure) => add(SyncError(failure.properties.first)),
          (data) async =>
              await saveSyncEvaluacionesRespuestas(data, emit, usuario));
    } else {
      await uploadExperienciaAgricola(usuario, emit);
    }
  }

  Future<void> saveSyncEvaluacionesRespuestas(
      List<EvaluacionRespuestaEntity> data,
      Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result =
        await evaluacionRespuestaDB.saveEvaluacionesRespuestasUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => uploadExperienciaAgricola(usuario, emit));
  }

  // Sync ExperienciaAgricola
  Future<void> uploadExperienciaAgricola(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Experiencias Agricolas',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await experienciaAgricolaDB
        .getExperienciasAgricolasProduccionUsecaseDB();
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await saveExperienciasAgricolasRemote(usuario, data, emit));
  }

  Future<void> saveExperienciasAgricolasRemote(UsuarioEntity usuario,
      List<ExperienciaAgricolaEntity> data, Emitter<SyncState> emit) async {
    final result = await experienciaAgricola.saveExperienciasAgricolasUsecase(
        usuario, data);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await updateExperienciasAgricolasProduccion(usuario, data, emit));
  }

  Future<void> updateExperienciasAgricolasProduccion(UsuarioEntity usuario,
      List<ExperienciaAgricolaEntity> data, Emitter<SyncState> emit) async {
    final result = await experienciaAgricolaDB
        .updateExperienciasAgricolasProduccionUsecaseDB(data);
    result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await syncExperienciasAgricolas(usuario, emit, data));
  }

  Future<void> syncExperienciasAgricolas(
      UsuarioEntity usuario, Emitter<SyncState> emit, int result) async {
    if (result == 0) {
      final result =
          await experienciaAgricola.getExperienciasAgricolasUsecase(usuario);
      return result.fold(
          (failure) => add(SyncError(failure.properties.first)),
          (data) async =>
              await saveSyncExperienciasAgricolas(data, emit, usuario));
    } else {
      await uploadExperienciaPecuaria(usuario, emit);
    }
  }

  Future<void> saveSyncExperienciasAgricolas(
      List<ExperienciaAgricolaEntity> data,
      Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result =
        await experienciaAgricolaDB.saveExperienciasAgricolasUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await uploadExperienciaPecuaria(usuario, emit));
  }

  // Sync  ExperienciaPecuaria
  Future<void> uploadExperienciaPecuaria(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando  Experiencias Pecuarias',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await experienciaPecuariaDB
        .getExperienciasPecuariasProduccionUsecaseDB();
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await saveExperienciasPecuariasRemote(usuario, data, emit));
  }

  Future<void> saveExperienciasPecuariasRemote(UsuarioEntity usuario,
      List<ExperienciaPecuariaEntity> data, Emitter<SyncState> emit) async {
    final result = await experienciaPecuaria.saveExperienciasPecuariasUsecase(
        usuario, data);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await updateExperienciasPecuariasProduccion(usuario, data, emit));
  }

  Future<void> updateExperienciasPecuariasProduccion(UsuarioEntity usuario,
      List<ExperienciaPecuariaEntity> data, Emitter<SyncState> emit) async {
    final result = await experienciaPecuariaDB
        .updateExperienciasPecuariasProduccionUsecaseDB(data);
    result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await syncExperienciasPecuarias(usuario, emit, data));
  }

  Future<void> syncExperienciasPecuarias(
      UsuarioEntity usuario, Emitter<SyncState> emit, int result) async {
    if (result == 0) {
      final result =
          await experienciaPecuaria.getExperienciasPecuariasUsecase(usuario);
      return result.fold(
          (failure) => add(SyncError(failure.properties.first)),
          (data) async =>
              await saveSyncExperienciasPecuarias(data, emit, usuario));
    } else {
      await uploadPerfilBeneficiario(usuario, emit);
    }
  }

  Future<void> saveSyncExperienciasPecuarias(
      List<ExperienciaPecuariaEntity> data,
      Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result =
        await experienciaPecuariaDB.saveExperienciasPecuariasUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await uploadPerfilBeneficiario(usuario, emit));
  }

  // Sync PerfilBeneficiario
  Future<void> uploadPerfilBeneficiario(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Perfiles Beneficiarios',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await perfilBeneficiarioDB
        .getPerfilesBeneficiariosProduccionUsecaseDB();
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await savePerfilesBeneficiariosRemote(usuario, data, emit));
  }

  Future<void> savePerfilesBeneficiariosRemote(UsuarioEntity usuario,
      List<PerfilBeneficiarioEntity> data, Emitter<SyncState> emit) async {
    final result = await perfilBeneficiario.savePerfilesBeneficiariosUsecase(
        usuario, data);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await updatePerfilesBeneficiariosProduccion(usuario, data, emit));
  }

  Future<void> updatePerfilesBeneficiariosProduccion(UsuarioEntity usuario,
      List<PerfilBeneficiarioEntity> data, Emitter<SyncState> emit) async {
    final result = await perfilBeneficiarioDB
        .updatePerfilesBeneficiariosProduccionUsecaseDB(data);
    result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await syncPerfilesBeneficiarios(usuario, emit, data));
  }

  Future<void> syncPerfilesBeneficiarios(
      UsuarioEntity usuario, Emitter<SyncState> emit, int result) async {
    if (result == 0) {
      final result =
          await perfilBeneficiario.getPerfilBeneficiariosUsecase(usuario);
      return result.fold(
          (failure) => add(SyncError(failure.properties.first)),
          (data) async =>
              await saveSyncPerfilesBeneficiarios(data, emit, usuario));
    } else {
      await uploadPerfilPreInversionAliado(usuario, emit);
    }
  }

  Future<void> saveSyncPerfilesBeneficiarios(
      List<PerfilBeneficiarioEntity> data,
      Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result =
        await perfilBeneficiarioDB.savePerfilBeneficiariosUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await uploadPerfilPreInversionAliado(usuario, emit));
  }

  // Sync PerfilPreInversionAliado
  Future<void> uploadPerfilPreInversionAliado(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Perfiles PreInversion Aliado',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await perfilPreInversionAliadoDB
        .getPerfilesPreInversionesAliadosProduccionUsecaseDB();
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await savePerfilesPreInversionesAliadosRemote(usuario, data, emit));
  }

  Future<void> savePerfilesPreInversionesAliadosRemote(
      UsuarioEntity usuario,
      List<PerfilPreInversionAliadoEntity> data,
      Emitter<SyncState> emit) async {
    final result = await perfilPreInversionAliado
        .savePerfilesPreInversionesAliadosUsecase(usuario, data);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async => await updatePerfilesPreInversionesAliadosProduccion(
            usuario, data, emit));
  }

  Future<void> updatePerfilesPreInversionesAliadosProduccion(
      UsuarioEntity usuario,
      List<PerfilPreInversionAliadoEntity> data,
      Emitter<SyncState> emit) async {
    final result = await perfilPreInversionAliadoDB
        .updatePerfilesPreInversionesAliadosProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await syncPerfilesPreInversionesAliados(usuario, emit, data));
  }

  Future<void> syncPerfilesPreInversionesAliados(
      UsuarioEntity usuario, Emitter<SyncState> emit, int result) async {
    if (result == 0) {
      final result = await perfilPreInversionAliado
          .getPerfilPreInversionAliadosUsecase(usuario);
      return result.fold(
          (failure) => add(SyncError(failure.properties.first)),
          (data) async =>
              await saveSyncPerfilesPreInversionesAliados(data, emit, usuario));
    } else {
      await uploadPerfilPreInversionBeneficiario(usuario, emit);
    }
  }

  Future<void> saveSyncPerfilesPreInversionesAliados(
      List<PerfilPreInversionAliadoEntity> data,
      Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result = await perfilPreInversionAliadoDB
        .savePerfilPreInversionAliadosUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await uploadPerfilPreInversionBeneficiario(usuario, emit));
  }

  // Sync PerfilPreInversionBeneficiario
  Future<void> uploadPerfilPreInversionBeneficiario(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Perfiles PreInversion Beneficiario',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await perfilPreInversionBeneficiarioDB
        .getPerfilesPreInversionesBeneficiariosProduccionUsecaseDB();
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async => await savePerfilesPreInversionesBeneficiariosRemote(
            usuario, data, emit));
  }

  Future<void> savePerfilesPreInversionesBeneficiariosRemote(
      UsuarioEntity usuario,
      List<PerfilPreInversionBeneficiarioEntity> data,
      Emitter<SyncState> emit) async {
    final result = await perfilPreInversionBeneficiario
        .savePerfilesPreInversionesBeneficiariosUsecase(usuario, data);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await updatePerfilesPreInversionesBeneficiariosProduccion(
                usuario, data, emit));
  }

  Future<void> updatePerfilesPreInversionesBeneficiariosProduccion(
      UsuarioEntity usuario,
      List<PerfilPreInversionBeneficiarioEntity> data,
      Emitter<SyncState> emit) async {
    final result = await perfilPreInversionBeneficiarioDB
        .updatePerfilesPreInversionesBeneficiariosProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await syncPerfilesPreInversionesBeneficiarios(usuario, emit, data));
  }

  Future<void> syncPerfilesPreInversionesBeneficiarios(
      UsuarioEntity usuario, Emitter<SyncState> emit, int result) async {
    if (result == 0) {
      final result = await perfilPreInversionBeneficiario
          .getPerfilPreInversionBeneficiariosUsecase(usuario);
      return result.fold(
          (failure) => add(SyncError(failure.properties.first)),
          (data) async => await saveSyncPerfilesPreInversionesBeneficiarios(
              data, emit, usuario));
    } else {
      await uploadPerfilPreInversionCofinanciador(usuario, emit);
    }
  }

  Future<void> saveSyncPerfilesPreInversionesBeneficiarios(
      List<PerfilPreInversionBeneficiarioEntity> data,
      Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result = await perfilPreInversionBeneficiarioDB
        .savePerfilPreInversionBeneficiariosUsecaseDB(data);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (_) async =>
            await uploadPerfilPreInversionCofinanciador(usuario, emit));
  }

  // Sync PerfilPreInversionCofinanciador
  Future<void> uploadPerfilPreInversionCofinanciador(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Perfiles PreInversion Cofinanciador',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await perfilPreInversionCofinanciadorDB
        .getPerfilesPreInversionesCofinanciadoresProduccionUsecaseDB();
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async => await savePerfilesPreInversionesCofinanciadoresRemote(
            usuario, data, emit));
  }

  Future<void> savePerfilesPreInversionesCofinanciadoresRemote(
      UsuarioEntity usuario,
      List<PerfilPreInversionCofinanciadorEntity> data,
      Emitter<SyncState> emit) async {
    final result = await perfilPreInversionCofinanciador
        .savePerfilesPreInversionesCofinanciadoresUsecase(usuario, data);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await updatePerfilesPreInversionesCofinanciadoresProduccion(
                usuario, data, emit));
  }

  Future<void> updatePerfilesPreInversionesCofinanciadoresProduccion(
      UsuarioEntity usuario,
      List<PerfilPreInversionCofinanciadorEntity> data,
      Emitter<SyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorDB
        .updatePerfilesPreInversionesCofinanciadoresProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async => await syncPerfilesPreInversionesCofinanciadores(
            usuario, emit, data));
  }

  Future<void> syncPerfilesPreInversionesCofinanciadores(
      UsuarioEntity usuario, Emitter<SyncState> emit, int result) async {
    if (result == 0) {
      final result = await perfilPreInversionCofinanciador
          .getPerfilPreInversionCofinanciadoresUsecase(usuario);
      return result.fold(
          (failure) => add(SyncError(failure.properties.first)),
          (data) async => await saveSyncPerfilesPreInversionesCofinanciadores(
              data, emit, usuario));
    } else {
      await uploadPerfilPreInversionCofinanciadorActividadFinanciera(
          usuario, emit);
    }
  }

  Future<void> saveSyncPerfilesPreInversionesCofinanciadores(
      List<PerfilPreInversionCofinanciadorEntity> data,
      Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result = await perfilPreInversionCofinanciadorDB
        .savePerfilesPreInversionesCofinanciadoresUsecaseDB(data);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (_) async =>
            await uploadPerfilPreInversionCofinanciadorActividadFinanciera(
                usuario, emit));
  }

  // Sync PerfilPreInversionCofinanciador Actividad Financiera
  Future<void> uploadPerfilPreInversionCofinanciadorActividadFinanciera(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title:
            'Sincronizando Perfiles PreInversion Cofinanciador Actividad Financiera',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await perfilPreInversionCofinanciadorActividadFinancieraDB
        .getPerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccionUsecaseDB();
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await savePerfilesPreInversionesCofinanciadoresActividadesFinancierasRemote(
                usuario, data, emit));
  }

  Future<void>
      savePerfilesPreInversionesCofinanciadoresActividadesFinancierasRemote(
          UsuarioEntity usuario,
          List<PerfilPreInversionCofinanciadorActividadFinancieraEntity> data,
          Emitter<SyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorActividadFinanciera
        .savePerfilesPreInversionesCofinanciadoresActividadesFinancierasUsecase(
            usuario, data);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await updatePerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccion(
                usuario, data, emit));
  }

  Future<void>
      updatePerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccion(
          UsuarioEntity usuario,
          List<PerfilPreInversionCofinanciadorActividadFinancieraEntity> data,
          Emitter<SyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorActividadFinancieraDB
        .updatePerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccionUsecaseDB(
            data);
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await syncPerfilesPreInversionesCofinanciadoresActividadesFinancieras(
                usuario, emit, data));
  }

  Future<void> syncPerfilesPreInversionesCofinanciadoresActividadesFinancieras(
      UsuarioEntity usuario, Emitter<SyncState> emit, int result) async {
    if (result == 0) {
      final result = await perfilPreInversionCofinanciadorActividadFinanciera
          .getPerfilPreInversionCofinanciadorActividadesFinancierasUsecase(
              usuario);
      return result.fold(
          (failure) => add(SyncError(failure.properties.first)),
          (data) async =>
              await saveSyncPerfilesPreInversionesCofinanciadoresActividadesFinancieras(
                  data, emit, usuario));
    } else {
      await uploadPerfilPreInversionCofinanciadorDesembolso(usuario, emit);
    }
  }

  Future<void>
      saveSyncPerfilesPreInversionesCofinanciadoresActividadesFinancieras(
          List<PerfilPreInversionCofinanciadorActividadFinancieraEntity> data,
          Emitter<SyncState> emit,
          UsuarioEntity usuario) async {
    final result = await perfilPreInversionCofinanciadorActividadFinancieraDB
        .savePerfilPreInversionCofinanciadorActividadesFinancierasUsecaseDB(
            data);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (_) async => await uploadPerfilPreInversionCofinanciadorDesembolso(
            usuario, emit));
  }

  // Sync PerfilPreInversionCofinanciador Desembolso
  Future<void> uploadPerfilPreInversionCofinanciadorDesembolso(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Perfiles PreInversion CofinanciadorDesembolso',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await perfilPreInversionCofinanciadorDesembolsoDB
        .getPerfilesPreInversionesCofinanciadoresDesembolsosProduccionUsecaseDB();
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await savePerfilesPreInversionesCofinanciadoresDesembolsosRemote(
                usuario, data, emit));
  }

  Future<void> savePerfilesPreInversionesCofinanciadoresDesembolsosRemote(
      UsuarioEntity usuario,
      List<PerfilPreInversionCofinanciadorDesembolsoEntity> data,
      Emitter<SyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorDesembolso
        .savePerfilesPreInversionesCofinanciadoresDesembolsosUsecase(
            usuario, data);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await updatePerfilesPreInversionesCofinanciadoresDesembolsosProduccion(
                usuario, data, emit));
  }

  Future<void> updatePerfilesPreInversionesCofinanciadoresDesembolsosProduccion(
      UsuarioEntity usuario,
      List<PerfilPreInversionCofinanciadorDesembolsoEntity> data,
      Emitter<SyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorDesembolsoDB
        .updatePerfilesPreInversionesCofinanciadoresDesembolsosProduccionUsecaseDB(
            data);
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await syncPerfilesPreInversionesCofinanciadoresDesembolsos(
                usuario, emit, data));
  }

  Future<void> syncPerfilesPreInversionesCofinanciadoresDesembolsos(
      UsuarioEntity usuario, Emitter<SyncState> emit, int result) async {
    if (result == 0) {
      final result = await perfilPreInversionCofinanciadorDesembolso
          .getPerfilPreInversionCofinanciadorDesembolsosUsecase(usuario);
      return result.fold(
          (failure) => add(SyncError(failure.properties.first)),
          (data) async =>
              await saveSyncPerfilesPreInversionesCofinanciadoresDesembolsos(
                  data, emit, usuario));
    } else {
      await uploadPerfilPreInversionCofinanciadorRubro(usuario, emit);
    }
  }

  Future<void> saveSyncPerfilesPreInversionesCofinanciadoresDesembolsos(
      List<PerfilPreInversionCofinanciadorDesembolsoEntity> data,
      Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result = await perfilPreInversionCofinanciadorDesembolsoDB
        .savePerfilPreInversionCofinanciadorDesembolsosUsecaseDB(data);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (_) async =>
            await uploadPerfilPreInversionCofinanciadorRubro(usuario, emit));
  }

  // Sync PerfilPreInversionCofinanciador Rubro
  Future<void> uploadPerfilPreInversionCofinanciadorRubro(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Perfiles PreInversion CofinanciadorRubro',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await perfilPreInversionCofinanciadorRubroDB
        .getPerfilesPreInversionesCofinanciadoresRubrosProduccionUsecaseDB();
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await savePerfilesPreInversionesCofinanciadoresRubrosRemote(
                usuario, data, emit));
  }

  Future<void> savePerfilesPreInversionesCofinanciadoresRubrosRemote(
      UsuarioEntity usuario,
      List<PerfilPreInversionCofinanciadorRubroEntity> data,
      Emitter<SyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorRubro
        .savePerfilesPreInversionesCofinanciadoresRubrosUsecase(usuario, data);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await updatePerfilesPreInversionesCofinanciadoresRubrosProduccion(
                usuario, data, emit));
  }

  Future<void> updatePerfilesPreInversionesCofinanciadoresRubrosProduccion(
      UsuarioEntity usuario,
      List<PerfilPreInversionCofinanciadorRubroEntity> data,
      Emitter<SyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorRubroDB
        .updatePerfilesPreInversionesCofinanciadoresRubrosProduccionUsecaseDB(
            data);
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async => await syncPerfilesPreInversionesCofinanciadoresRubros(
            usuario, emit, data));
  }

  Future<void> syncPerfilesPreInversionesCofinanciadoresRubros(
      UsuarioEntity usuario, Emitter<SyncState> emit, int result) async {
    if (result == 0) {
      final result = await perfilPreInversionCofinanciadorRubro
          .getPerfilPreInversionCofinanciadorRubrosUsecase(usuario);
      return result.fold(
          (failure) => add(SyncError(failure.properties.first)),
          (data) async =>
              await saveSyncPerfilesPreInversionesCofinanciadoresRubros(
                  data, emit, usuario));
    } else {
      await uploadPerfilPreInversionConsultor(usuario, emit);
    }
  }

  Future<void> saveSyncPerfilesPreInversionesCofinanciadoresRubros(
      List<PerfilPreInversionCofinanciadorRubroEntity> data,
      Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result = await perfilPreInversionCofinanciadorRubroDB
        .savePerfilPreInversionCofinanciadorRubrosUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await uploadPerfilPreInversionConsultor(usuario, emit));
  }

  // Sync PerfilPreInversion Consultor
  Future<void> uploadPerfilPreInversionConsultor(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Perfiles PreInversion Consultor',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await perfilPreInversionConsultorDB
        .getPerfilesPreInversionesConsultoresProduccionUsecaseDB();
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async => await savePerfilesPreInversionesConsultoresRemote(
            usuario, data, emit));
  }

  Future<void> savePerfilesPreInversionesConsultoresRemote(
      UsuarioEntity usuario,
      List<PerfilPreInversionConsultorEntity> data,
      Emitter<SyncState> emit) async {
    final result = await perfilPreInversionConsultor
        .savePerfilesPreInversionesConsultoresUsecase(usuario, data);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async => await updatePerfilesPreInversionesConsultoresProduccion(
            usuario, data, emit));
  }

  Future<void> updatePerfilesPreInversionesConsultoresProduccion(
      UsuarioEntity usuario,
      List<PerfilPreInversionConsultorEntity> data,
      Emitter<SyncState> emit) async {
    final result = await perfilPreInversionConsultorDB
        .updatePerfilesPreInversionesConsultoresProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await syncPerfilesPreInversionesConsultores(usuario, emit, data));
  }

  Future<void> syncPerfilesPreInversionesConsultores(
      UsuarioEntity usuario, Emitter<SyncState> emit, int result) async {
    if (result == 0) {
      final result = await perfilPreInversionConsultor
          .getPerfilPreInversionConsultoresUsecase(usuario);
      return result.fold(
          (failure) => add(SyncError(failure.properties.first)),
          (data) async => await saveSyncPerfilesPreInversionesConsultores(
              data, emit, usuario));
    } else {
      await uploadPerfilPreInversionPlanNegocio(usuario, emit);
    }
  }

  Future<void> saveSyncPerfilesPreInversionesConsultores(
      List<PerfilPreInversionConsultorEntity> data,
      Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result = await perfilPreInversionConsultorDB
        .savePerfilPreInversionConsultoresUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await uploadPerfilPreInversionPlanNegocio(usuario, emit));
  }

  // Sync PerfilPreInversion Plan Negocio
  Future<void> uploadPerfilPreInversionPlanNegocio(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Perfiles PreInversion PlanNegocio',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await perfilPreInversionPlanNegocioDB
        .getPerfilesPreInversionesPlanNegociosProduccionUsecaseDB();
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async => await savePerfilesPreInversionesPlanNegociosRemote(
            usuario, data, emit));
  }

  Future<void> savePerfilesPreInversionesPlanNegociosRemote(
      UsuarioEntity usuario,
      List<PerfilPreInversionPlanNegocioEntity> data,
      Emitter<SyncState> emit) async {
    final result = await perfilPreInversionPlanNegocio
        .savePerfilesPreInversionesPlanNegociosUsecase(usuario, data);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await updatePerfilesPreInversionesPlanNegociosProduccion(
                usuario, data, emit));
  }

  Future<void> updatePerfilesPreInversionesPlanNegociosProduccion(
      UsuarioEntity usuario,
      List<PerfilPreInversionPlanNegocioEntity> data,
      Emitter<SyncState> emit) async {
    final result = await perfilPreInversionPlanNegocioDB
        .updatePerfilesPreInversionesPlanNegociosProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await syncPerfilesPreInversionesPlanNegocios(usuario, emit, data));
  }

  Future<void> syncPerfilesPreInversionesPlanNegocios(
      UsuarioEntity usuario, Emitter<SyncState> emit, int result) async {
    if (result == 0) {
      final result = await perfilPreInversionPlanNegocio
          .getPerfilPreInversionPlanNegociosUsecase(usuario);
      return result.fold(
          (failure) => add(SyncError(failure.properties.first)),
          (data) async => await saveSyncPerfilesPreInversionesPlanNegocios(
              data, emit, usuario));
    } else {
      await uploadPerfilPreInversionPrecio(usuario, emit);
    }
  }

  Future<void> saveSyncPerfilesPreInversionesPlanNegocios(
      List<PerfilPreInversionPlanNegocioEntity> data,
      Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result = await perfilPreInversionPlanNegocioDB
        .savePerfilPreInversionPlanNegociosUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await uploadPerfilPreInversionPrecio(usuario, emit));
  }

  // Sync PerfilPreInversion Precio
  Future<void> uploadPerfilPreInversionPrecio(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Perfiles PreInversion Precio',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await perfilPreInversionPrecioDB
        .getPerfilesPreInversionesPreciosProduccionUsecaseDB();
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await savePerfilesPreInversionesPreciosRemote(usuario, data, emit));
  }

  Future<void> savePerfilesPreInversionesPreciosRemote(
      UsuarioEntity usuario,
      List<PerfilPreInversionPrecioEntity> data,
      Emitter<SyncState> emit) async {
    final result = await perfilPreInversionPrecio
        .savePerfilesPreInversionesPreciosUsecase(usuario, data);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async => await updatePerfilesPreInversionesPreciosProduccion(
            usuario, data, emit));
  }

  Future<void> updatePerfilesPreInversionesPreciosProduccion(
      UsuarioEntity usuario,
      List<PerfilPreInversionPrecioEntity> data,
      Emitter<SyncState> emit) async {
    final result = await perfilPreInversionPrecioDB
        .updatePerfilesPreInversionesPreciosProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (data) async =>
            await syncPerfilesPreInversionesPrecios(usuario, emit, data));
  }

  Future<void> syncPerfilesPreInversionesPrecios(
      UsuarioEntity usuario, Emitter<SyncState> emit, int result) async {
    if (result == 0) {
      final result = await perfilPreInversionPrecio
          .getPerfilPreInversionPreciosUsecase(usuario);
      return result.fold(
          (failure) => add(SyncError(failure.properties.first)),
          (data) async =>
              await saveSyncPerfilesPreInversionesPrecios(data, emit, usuario));
    } else {
      await uploadVisita(usuario, emit);
    }
  }

  Future<void> saveSyncPerfilesPreInversionesPrecios(
      List<PerfilPreInversionPrecioEntity> data,
      Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result = await perfilPreInversionPrecioDB
        .savePerfilPreInversionPreciosUsecaseDB(data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (_) async => await uploadVisita(usuario, emit));
  }

  // Sync Visita
  Future<void> uploadVisita(
      UsuarioEntity usuario, Emitter<SyncState> emit) async {
    add(SyncStatusChanged(state.syncProgressModel!.copyWith(
        title: 'Sincronizando Visitas',
        counter: state.syncProgressModel!.counter + 1,
        total: gTotal,
        percent: calculatePercent())));
    final result = await visitaDB.getVisitasProduccionUsecaseDB();
    result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await saveVisitasRemote(usuario, data, emit));
  }

  Future<void> saveVisitasRemote(UsuarioEntity usuario, List<VisitaEntity> data,
      Emitter<SyncState> emit) async {
    final result = await visita.saveVisitasUsecase(usuario, data);
    return result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await updateVisitasProduccion(usuario, data, emit));
  }

  Future<void> updateVisitasProduccion(UsuarioEntity usuario,
      List<VisitaEntity> data, Emitter<SyncState> emit) async {
    final result = await visitaDB.updateVisitasProduccionUsecaseDB(data);
    result.fold((failure) => add(SyncError(failure.properties.first)),
        (data) async => await syncVisitas(usuario, emit, data));
  }

  Future<void> syncVisitas(
      UsuarioEntity usuario, Emitter<SyncState> emit, int result) async {
    if (result == 0) {
      final result = await visita.getVisitasUsecase(usuario);
      return result.fold((failure) => add(SyncError(failure.properties.first)),
          (data) async => await saveSyncVisitas(data, emit, usuario));
    } else {
      add(SyncStatusChanged(state.syncProgressModel!.copyWith(
          title: 'Sincronización Completada',
          counter: state.syncProgressModel!.counter + 1,
          percent: calculatePercent())));
    }
  }

  Future<void> saveSyncVisitas(List<VisitaEntity> data, Emitter<SyncState> emit,
      UsuarioEntity usuario) async {
    final result = await visitaDB.saveVisitasUsecaseDB(data);
    return result.fold(
        (failure) => add(SyncError(failure.properties.first)),
        (_) async => add(SyncStatusChanged(state.syncProgressModel!.copyWith(
            title: 'Sincronización Completada',
            counter: state.syncProgressModel!.counter + 1,
            percent: calculatePercent()))));
  }
}
