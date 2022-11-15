import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/vereda_model.dart';
import '../../entities/usuario_entity.dart';
import '../../usecases/actividad_economica/actividad_economica_exports.dart';
import '../../usecases/actividad_financiera/actividad_financiera_exports.dart';
import '../../usecases/agrupacion/agrupacion_exports.dart';
import '../../usecases/aliado/aliado_exports.dart';
import '../../usecases/evaluacion_respuesta/evaluacion_respuesta_exports.dart';
import '../../usecases/perfil_preinversion_aliado/perfil_preinversion_aliado_exports.dart';
import '../../usecases/alianza/alianza_exports.dart';
import '../../usecases/beneficiario/beneficiario_exports.dart';
import '../../usecases/beneficiario_alianza/beneficiario_alianza_exports.dart';
import '../../usecases/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_exports.dart';
import '../../usecases/cofinanciador/cofinanciador_exports.dart';
import '../../usecases/consultor/consultor_exports.dart';
import '../../usecases/convocatoria/convocatoria_exports.dart';
import '../../usecases/criterio/criterio_exports.dart';
import '../../usecases/departamento/departamento_exports.dart';
import '../../usecases/desembolso/desembolso_exports.dart';
import '../../usecases/estado_civil/estado_civil_exports.dart';
import '../../usecases/estado_visita/estado_visita_exports.dart';
import '../../usecases/evaluacion/evaluacion_exports.dart';
import '../../usecases/frecuencia/frecuencia_exports.dart';
import '../../usecases/genero/genero_exports.dart';
import '../../usecases/grupo_especial/grupo_especial_exports.dart';
import '../../usecases/menu/menu_exports.dart';
import '../../usecases/municipio/municipio_exports.dart';
import '../../usecases/nivel_escolar/nivel_escolar_exports.dart';
import '../../usecases/opcion/opcion_exports.dart';
import '../../usecases/perfil/perfil_exports.dart';
import '../../usecases/perfil_preinversion/perfil_preinversion_exports.dart';
import '../../usecases/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_exports.dart';
import '../../usecases/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_exports.dart';
import '../../usecases/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_exports.dart';
import '../../usecases/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_exports.dart';
import '../../usecases/perfil_preinversion_consultor/perfil_preinversion_consultor_exports.dart';
import '../../usecases/perfil_preinversion_precio/perfil_preinversion_precio_exports.dart';
import '../../usecases/producto/producto_exports.dart';
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

part 'download_sync_event.dart';
part 'download_sync_state.dart';

class DownloadSyncBloc extends Bloc<DownloadSyncEvent, DownloadSyncState> {
  final ActividadEconomicaUsecase actividadEconomica;
  final ActividadEconomicaUsecaseDB actividadEconomicaDB;
  final ActividadFinancieraUsecase actividadFinanciera;
  final ActividadFinancieraUsecaseDB actividadFinancieraDB;
  final AgrupacionUsecase agrupacion;
  final AgrupacionUsecaseDB agrupacionDB;
  final PerfilPreInversionAliadoUsecase perfilPreInversionAliados;
  final PerfilPreInversionAliadoUsecaseDB perfilPreInversionAliadosDB;
  final AliadoUsecase aliado;
  final AliadoUsecaseDB aliadoDB;
  final AlianzaUsecase alianza;
  final AlianzaUsecaseDB alianzaDB;
  final BeneficiarioAlianzaUsecase beneficiarioAlianza;
  final BeneficiarioAlianzaUsecaseDB beneficiarioAlianzaDB;
  final PerfilPreInversionBeneficiarioUsecase perfilPreInversionBeneficiario;
  final PerfilPreInversionBeneficiarioUsecaseDB
      perfilPreInversionBeneficiarioDB;
  final BeneficiarioUsecase beneficiario;
  final BeneficiarioUsecaseDB beneficiarioDB;
  final CofinanciadorUsecase cofinanciador;
  final CofinanciadorUsecaseDB cofinanciadorDB;
  final ConsultorUsecase consultor;
  final ConsultorUsecaseDB consultorDB;
  final ConvocatoriaUsecase convocatoria;
  final ConvocatoriaUsecaseDB convocatoriaDB;
  final CriterioUsecase criterio;
  final CriterioUsecaseDB criterioDB;
  final DepartamentoUsecase departamentos;
  final DepartamentoUsecaseDB departamentosDB;
  final DesembolsoUsecase desembolso;
  final DesembolsoUsecaseDB desembolsoDB;
  final EstadoCivilUsecase estadoCivil;
  final EstadoCivilUsecaseDB estadoCivilDB;
  final EstadoVisitaUsecase estadoVisita;
  final EstadoVisitaUsecaseDB estadoVisitaDB;
  final EvaluacionRespuestaUsecase evaluacionRespuesta;
  final EvaluacionRespuestaUsecaseDB evaluacionRespuestaDB;
  final EvaluacionUsecase evaluacion;
  final EvaluacionUsecaseDB evaluacionDB;
  final FrecuenciaUsecase frecuencia;
  final FrecuenciaUsecaseDB frecuenciaDB;
  final GeneroUsecase generos;
  final GeneroUsecaseDB generosDB;
  final GrupoEspecialUsecase grupoEspecial;
  final GrupoEspecialUsecaseDB grupoEspecialDB;
  final MenuUsecase menu;
  final MenuUsecaseDB menuDB;
  final MunicipioUsecase municipios;
  final MunicipioUsecaseDB municipiosDB;
  final NivelEscolarUsecase nivelEscolar;
  final NivelEscolarUsecaseDB nivelEscolarDB;
  final OpcionUsecase opcion;
  final OpcionUsecaseDB opcionDB;
  final PerfilPreInversionUsecase perfilesPreInversion;
  final PerfilPreInversionUsecaseDB perfilesPreInversionDB;
  final PerfilUsecase perfiles;
  final PerfilUsecaseDB perfilesDB;
  final ProductoUsecase productos;
  final ProductoUsecaseDB productosDB;
  final ResidenciaUsecase residencia;
  final ResidenciaUsecaseDB residenciaDB;
  final RevisionUsecase revision;
  final RevisionUsecaseDB revisionDB;
  final RubroUsecase rubro;
  final RubroUsecaseDB rubroDB;
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
  final VisitaUsecase visita;
  final VisitaUsecaseDB visitaDB;
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
  final PerfilPreInversionCofinanciadorUsecase perfilPreInversionCofinanciador;
  final PerfilPreInversionCofinanciadorUsecaseDB
      perfilPreInversionCofinanciadorDB;
  final PerfilPreInversionConsultorUsecase perfilPreInversionConsultor;
  final PerfilPreInversionConsultorUsecaseDB perfilPreInversionConsultorDB;
  final PerfilPreInversionPrecioUsecase perfilPreInversionPrecio;
  final PerfilPreInversionPrecioUsecaseDB perfilPreInversionPrecioDB;

  DownloadSyncBloc(
      {required this.actividadEconomica,
      required this.actividadEconomicaDB,
      required this.actividadFinanciera,
      required this.actividadFinancieraDB,
      required this.agrupacion,
      required this.agrupacionDB,
      required this.aliado,
      required this.aliadoDB,
      required this.perfilPreInversionAliados,
      required this.perfilPreInversionAliadosDB,
      required this.alianza,
      required this.alianzaDB,
      required this.beneficiario,
      required this.beneficiarioAlianza,
      required this.beneficiarioAlianzaDB,
      required this.beneficiarioDB,
      required this.perfilPreInversionBeneficiario,
      required this.perfilPreInversionBeneficiarioDB,
      required this.cofinanciador,
      required this.cofinanciadorDB,
      required this.consultor,
      required this.consultorDB,
      required this.convocatoria,
      required this.convocatoriaDB,
      required this.criterio,
      required this.criterioDB,
      required this.departamentos,
      required this.departamentosDB,
      required this.desembolso,
      required this.desembolsoDB,
      required this.estadoCivil,
      required this.estadoCivilDB,
      required this.estadoVisita,
      required this.estadoVisitaDB,
      required this.evaluacion,
      required this.evaluacionDB,
      required this.evaluacionRespuesta,
      required this.evaluacionRespuestaDB,
      required this.frecuencia,
      required this.frecuenciaDB,
      required this.generos,
      required this.generosDB,
      required this.grupoEspecial,
      required this.grupoEspecialDB,
      required this.menu,
      required this.menuDB,
      required this.municipios,
      required this.municipiosDB,
      required this.nivelEscolar,
      required this.nivelEscolarDB,
      required this.opcion,
      required this.opcionDB,
      required this.perfiles,
      required this.perfilesDB,
      required this.perfilesPreInversion,
      required this.perfilesPreInversionDB,
      required this.productos,
      required this.productosDB,
      required this.residencia,
      required this.residenciaDB,
      required this.revision,
      required this.revisionDB,
      required this.rubro,
      required this.rubroDB,
      required this.sitioEntrega,
      required this.sitioEntregaDB,
      required this.tipoActividadProductiva,
      required this.tipoActividadProductivaDB,
      required this.tipoCalidad,
      required this.tipoCalidadDB,
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
      required this.visita,
      required this.visitaDB,
      required this.perfilPreInversionCofinanciadorActividadFinanciera,
      required this.perfilPreInversionCofinanciadorActividadFinancieraDB,
      required this.perfilPreInversionCofinanciadorDesembolso,
      required this.perfilPreInversionCofinanciadorDesembolsoDB,
      required this.perfilPreInversionCofinanciadorRubro,
      required this.perfilPreInversionCofinanciadorRubroDB,
      required this.perfilPreInversionCofinanciador,
      required this.perfilPreInversionCofinanciadorDB,
      required this.perfilPreInversionConsultor,
      required this.perfilPreInversionConsultorDB,
      required this.perfilPreInversionPrecio,
      required this.perfilPreInversionPrecioDB})
      : super(DownloadSyncInitial()) {
    on<DownloadStarted>((event, emit) async {
      final usuario = event.usuario;

      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Menús',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
      await downloadMenu(usuario, emit);

      await downloadConvocatorias(usuario, emit);

      await downloadTiposProyectos(usuario, emit);

      await downloadUnidades(usuario, emit);

      await downloadPerfiles(usuario, emit);

      await downloadPerfilesPreInversion(usuario, emit);

      await downloadProductos(usuario, emit);

      await downloadGeneros(usuario, emit);

      await downloadDepartamentos(usuario, emit);

      await downloadMunicipios(usuario, emit);

      await downloadTiposVisitas(usuario, emit);

      await downloadEstadosVisitas(usuario, emit);

      await downloadAgrupaciones(usuario, emit);

      await downloadEstadosCiviles(usuario, emit);

      await downloadResidencias(usuario, emit);

      await downloadTiposTenencias(usuario, emit);

      await downloadNivelesEscolares(usuario, emit);

      await downloadAlianzas(usuario, emit);

      await downloadAliados(usuario, emit);

      await downloadFrecuencias(usuario, emit);

      await downloadBeneficiarios(usuario, emit);

      await downloadGruposEspeciales(usuario, emit);

      await downloadTipoIdentificacion(usuario, emit);

      await downloadRevisiones(usuario, emit);

      await downloadConsultores(usuario, emit);

      await downloadTiposEntidades(usuario, emit);

      await downloadCofinanciadores(usuario, emit);

      await downloadDesembolsos(usuario, emit);

      await downloadRubros(usuario, emit);

      await downloadActividadesFinancieras(usuario, emit);

      await downloadTiposMovimientos(usuario, emit);

      await downloadTiposCalidades(usuario, emit);

      await downloadTiposActividadesProductivas(usuario, emit);

      await downloadActividadesEconomicas(usuario, emit);

      await downloadOpciones(usuario, emit);

      await downloadCriterios(usuario, emit);

      await downloadVisitas(usuario, emit);

      await downloadSitiosEntregas(usuario, emit);

      await downloadEvaluaciones(usuario, emit);

      await downloadEvaluacionesRespuestas(usuario, emit);

      await downloadPerfilPreInversionBeneficiarios(usuario, emit);

      await downloadBeneficiariosAlianza(usuario, emit);

      await downloadPerfilPreInversionAliados(usuario, emit);

      await downloadPerfilPreInversionCofinanciadorActividadesFinancieras(
          usuario, emit);

      await downloadPerfilPreInversionCofinanciadorDesembolsos(usuario, emit);

      await downloadPerfilPreInversionCofinanciadorRubros(usuario, emit);

      await downloadPerfilPreInversionCofinanciadores(usuario, emit);

      await downloadPerfilPreInversionConsultores(usuario, emit);

      await downloadPerfilPreInversionPrecios(usuario, emit);

      await downloadTiposDiscapacidades(usuario, emit);

      //await getMunicipiosPerfilesDB(usuario, emit);
    });

    on<DownloadStatusChanged>((event, emit) {
      event.progress.counter == 50
          ? emit(DownloadSyncSuccess())
          : emit(DownloadSyncInProgress(event.progress));
    });

    on<DownloadSyncError>(
        (event, emit) => emit(DownloadSyncFailure(event.message)));
  }

  double calculatePercent() {
    final counter = state.downloadProgressModel!.counter;
    final total = state.downloadProgressModel!.total;
    final percent = ((counter / total) * 100) / 100;

    return percent;
  }

  Future<void> downloadMenu(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await menu.getMenuUsecase(usuario);
    result.fold((failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveMenu(data, emit));
  }

  Future<void> saveMenu(
      List<MenuEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await menuDB.saveMenuUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Convocatorias',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadConvocatorias(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await convocatoria.getConvocatoriasUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveConvocatorias(data, emit));
  }

  Future<void> saveConvocatorias(
      List<ConvocatoriaEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await convocatoriaDB.saveConvocatoriaUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Tipos Proyectos',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadTiposProyectos(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await tipoProyecto.getTiposProyectosUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveTiposProyectos(data, emit));
  }

  Future<void> saveTiposProyectos(
      List<TipoProyectoEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await tipoProyectoDB.saveTiposProyectosUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Unidades',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadUnidades(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await unidad.getUnidadesUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveUnidades(data, emit));
  }

  Future<void> saveUnidades(
      List<UnidadEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await unidadDB.saveUnidadesUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Perfiles',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadPerfiles(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await perfiles.getPerfilesUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await savePerfiles(data, emit));
  }

  Future<void> savePerfiles(
      List<PerfilEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await perfilesDB.savePerfilesUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Perfiles PreInversion',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadPerfilesPreInversion(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result =
        await perfilesPreInversion.getPerfilesPreInversionUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await savePerfilesPreInversion(data, emit));
  }

  Future<void> savePerfilesPreInversion(List<PerfilPreInversionEntity> data,
      Emitter<DownloadSyncState> emit) async {
    final result =
        await perfilesPreInversionDB.savePerfilesPreInversionUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Productos',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadProductos(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await productos.getProductosUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveProductos(data, emit));
  }

  Future<void> saveProductos(
      List<ProductoEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await productosDB.saveProductoUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Géneros',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadGeneros(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await generos.getGenerosUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveGeneros(data, emit));
  }

  Future<void> saveGeneros(
      List<GeneroEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await generosDB.saveGenerosUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Departamentos',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadDepartamentos(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await departamentos.getDepartamentosUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveDepartamentos(data, emit));
  }

  Future<void> saveDepartamentos(
      List<DepartamentoEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await departamentosDB.saveDepartamentosUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Municipios',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadMunicipios(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await municipios.getMunicipiosUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveMunicipios(data, emit));
  }

  Future<void> saveMunicipios(
      List<MunicipioEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await municipiosDB.saveMunicipiosUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Tipos Visita',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadTiposVisitas(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await tipoVisita.getTiposVisitasUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveTiposVisitas(data, emit));
  }

  Future<void> saveTiposVisitas(
      List<TipoVisitaEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await tipoVisitaDB.saveTiposVisitasUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Estados Visita',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadEstadosVisitas(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await estadoVisita.getEstadosVisitasUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveEstadosVisitas(data, emit));
  }

  Future<void> saveEstadosVisitas(
      List<EstadoVisitaEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await estadoVisitaDB.saveEstadosVisitasUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Agrupaciones',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadAgrupaciones(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await agrupacion.getAgrupacionesUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveAgrupaciones(data, emit));
  }

  Future<void> saveAgrupaciones(
      List<AgrupacionEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await agrupacionDB.saveAgrupacionesUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Estados Civiles',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadEstadosCiviles(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await estadoCivil.getEstadosCivilesUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveEstadosCiviles(data, emit));
  }

  Future<void> saveEstadosCiviles(
      List<EstadoCivilEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await estadoCivilDB.saveEstadosCivilesUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Residencias',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadResidencias(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await residencia.getResidenciasUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveResidencias(data, emit));
  }

  Future<void> saveResidencias(
      List<ResidenciaEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await residenciaDB.saveResidenciasUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Tipos Tenencia',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadTiposTenencias(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await tipoTenencia.getTiposTenenciasUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveTiposTenencias(data, emit));
  }

  Future<void> saveTiposTenencias(
      List<TipoTenenciaEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await tipoTenenciaDB.saveTiposTenenciasUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Niveles Escolares',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadNivelesEscolares(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await nivelEscolar.getNivelesEscolaresUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveNivelesEscolares(data, emit));
  }

  Future<void> saveNivelesEscolares(
      List<NivelEscolarEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await nivelEscolarDB.saveNivelesEscolaresUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Alianzas',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadAlianzas(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await alianza.getAlianzasUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveAlianzas(data, emit));
  }

  Future<void> saveAlianzas(
      List<AlianzaEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await alianzaDB.saveAlianzasUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Aliados',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadAliados(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await aliado.getAliadosUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveAliados(data, emit));
  }

  Future<void> saveAliados(
      List<AliadoEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await aliadoDB.saveAliadosUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Frecuencias',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadFrecuencias(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await frecuencia.getFrecuenciasUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveFrecuencias(data, emit));
  }

  Future<void> saveFrecuencias(
      List<FrecuenciaEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await frecuenciaDB.saveFrecuenciasUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Beneficiarios',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadBeneficiarios(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await beneficiario.getBeneficiariosUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveBeneficiarios(data, emit));
  }

  Future<void> saveBeneficiarios(
      List<BeneficiarioEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await beneficiarioDB.saveBeneficiariosUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Grupos Especiales',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadGruposEspeciales(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await grupoEspecial.getGruposEspecialesUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveGruposEspeciales(data, emit));
  }

  Future<void> saveGruposEspeciales(
      List<GrupoEspecialEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await grupoEspecialDB.saveGrupoEspecialUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Tipos de Identificacion',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadTipoIdentificacion(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result =
        await tipoIdentificacion.getTiposIdentificacionesUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveTipoIdentificacion(data, emit));
  }

  Future<void> saveTipoIdentificacion(List<TipoIdentificacionEntity> data,
      Emitter<DownloadSyncState> emit) async {
    final result =
        await tipoIdentificacionDB.saveTiposIdentificacionesUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Revisiones',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadRevisiones(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await revision.getRevisionesUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveRevisiones(data, emit));
  }

  Future<void> saveRevisiones(
      List<RevisionEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await revisionDB.saveRevisionesUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Consultores',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadConsultores(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await consultor.getConsultoresUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveConsultores(data, emit));
  }

  Future<void> saveConsultores(
      List<ConsultorEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await consultorDB.saveConsultoresUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Tipos Entidades',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadTiposEntidades(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await tipoEntidad.getTiposEntidadesUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveTiposEntidades(data, emit));
  }

  Future<void> saveTiposEntidades(
      List<TipoEntidadEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await tipoEntidadDB.saveTiposEntidadesUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Cofinanciadores',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadCofinanciadores(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await cofinanciador.getCofinanciadoresUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveCofinanciadores(data, emit));
  }

  Future<void> saveCofinanciadores(
      List<CofinanciadorEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await cofinanciadorDB.saveCofinanciadoresUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Desembolsos',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadDesembolsos(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await desembolso.getDesembolsosUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveDesembolsos(data, emit));
  }

  Future<void> saveDesembolsos(
      List<DesembolsoEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await desembolsoDB.saveDesembolsosUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Rubros',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadRubros(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await rubro.getRubrosUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveRubros(data, emit));
  }

  Future<void> saveRubros(
      List<RubroEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await rubroDB.saveRubrosUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Actividades Financieras',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadActividadesFinancieras(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result =
        await actividadFinanciera.getActividadesFinancierasUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveActividadesFinancieras(data, emit));
  }

  Future<void> saveActividadesFinancieras(List<ActividadFinancieraEntity> data,
      Emitter<DownloadSyncState> emit) async {
    final result =
        await actividadFinancieraDB.saveActividadesFinancierasUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Tipos Movimientos',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadTiposMovimientos(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await tipoMovimiento.getTiposMovimientosUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveTiposMovimientos(data, emit));
  }

  Future<void> saveTiposMovimientos(
      List<TipoMovimientoEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await tipoMovimientoDB.saveTiposMovimientosUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Tipos Calidades',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadTiposCalidades(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await tipoCalidad.getTiposCalidadesUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveTiposCalidades(data, emit));
  }

  Future<void> saveTiposCalidades(
      List<TipoCalidadEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await tipoCalidadDB.saveTiposCalidadesUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Tipos Actividades Productivas',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadTiposActividadesProductivas(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await tipoActividadProductiva
        .getTiposActividadesProductivasUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveTiposActividadesProductivas(data, emit));
  }

  Future<void> saveTiposActividadesProductivas(
      List<TipoActividadProductivaEntity> data,
      Emitter<DownloadSyncState> emit) async {
    final result = await tipoActividadProductivaDB
        .saveTiposActividadesProductivasUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Actividades Económicas',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadActividadesEconomicas(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result =
        await actividadEconomica.getActividadesEconomicasUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveActividadesEconomicas(data, emit));
  }

  Future<void> saveActividadesEconomicas(List<ActividadEconomicaEntity> data,
      Emitter<DownloadSyncState> emit) async {
    final result =
        await actividadEconomicaDB.saveActividadesEconomicasUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Opciones',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadOpciones(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await opcion.getOpcionesUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveOpciones(data, emit));
  }

  Future<void> saveOpciones(
      List<OpcionEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await opcionDB.saveOpcionesUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Criterios',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadCriterios(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await criterio.getCriteriosUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveCriterios(data, emit));
  }

  Future<void> saveCriterios(
      List<CriterioEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await criterioDB.saveCriteriosUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Visitas',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadVisitas(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await visita.getVisitasUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveVisitas(data, emit));
  }

  Future<void> saveVisitas(
      List<VisitaEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await visitaDB.saveVisitasUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Sitios de Entrega',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadSitiosEntregas(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await sitioEntrega.getSitiosEntregasUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveSitiosEntregas(data, emit));
  }

  Future<void> saveSitiosEntregas(
      List<SitioEntregaEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await sitioEntregaDB.saveSitiosEntregasUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Evaluaciones',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadEvaluaciones(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await evaluacion.getEvaluacionesUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveEvaluaciones(data, emit));
  }

  Future<void> saveEvaluaciones(
      List<EvaluacionEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await evaluacionDB.saveEvaluacionesUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Evaluaciones Respuestas',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadEvaluacionesRespuestas(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result =
        await evaluacionRespuesta.getEvaluacionesRespuestasUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveEvaluacionesRespuestas(data, emit));
  }

  Future<void> saveEvaluacionesRespuestas(List<EvaluacionRespuestaEntity> data,
      Emitter<DownloadSyncState> emit) async {
    final result =
        await evaluacionRespuestaDB.saveEvaluacionesRespuestasUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Beneficiarios PreInversion',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadPerfilPreInversionBeneficiarios(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await perfilPreInversionBeneficiario
        .getPerfilPreInversionBeneficiariosUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await savePerfilPreInversionBeneficiarios(data, emit));
  }

  Future<void> savePerfilPreInversionBeneficiarios(
      List<PerfilPreInversionBeneficiarioEntity> data,
      Emitter<DownloadSyncState> emit) async {
    final result = await perfilPreInversionBeneficiarioDB
        .savePerfilPreInversionBeneficiariosUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Beneficiarios Alianza',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadBeneficiariosAlianza(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result =
        await beneficiarioAlianza.getBeneficiariosAlianzaUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveBeneficiariosAlianza(data, emit));
  }

  Future<void> saveBeneficiariosAlianza(List<BeneficiarioAlianzaEntity> data,
      Emitter<DownloadSyncState> emit) async {
    final result =
        await beneficiarioAlianzaDB.saveBeneficiariosAlianzaUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Perfiles PreInversion Aliados',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadPerfilPreInversionAliados(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await perfilPreInversionAliados
        .getPerfilPreInversionAliadosUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await savePerfilPreInversionAliados(data, emit));
  }

  Future<void> savePerfilPreInversionAliados(
      List<PerfilPreInversionAliadoEntity> data,
      Emitter<DownloadSyncState> emit) async {
    final result = await perfilPreInversionAliadosDB
        .savePerfilPreInversionAliadosUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title:
              'Sincronizando Perfiles PreInversion Cofinanciador Actividades Financieras',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadPerfilPreInversionCofinanciadorActividadesFinancieras(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorActividadFinanciera
        .getPerfilPreInversionCofinanciadorActividadesFinancierasUsecase(
            usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async =>
            await savePerfilPreInversionCofinanciadorActividadesFinancieras(
                data, emit));
  }

  Future<void> savePerfilPreInversionCofinanciadorActividadesFinancieras(
      List<PerfilPreInversionCofinanciadorActividadFinancieraEntity> data,
      Emitter<DownloadSyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorActividadFinancieraDB
        .getPerfilPreInversionCofinanciadorActividadesFinancierasUsecaseDB();
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title:
              'Sincronizando Perfiles PreInversion Cofinanciador Desembolsos',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadPerfilPreInversionCofinanciadorDesembolsos(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorDesembolso
        .getPerfilPreInversionCofinanciadorDesembolsosUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async =>
            await savePerfilPreInversionCofinanciadorDesembolsos(data, emit));
  }

  Future<void> savePerfilPreInversionCofinanciadorDesembolsos(
      List<PerfilPreInversionCofinanciadorDesembolsoEntity> data,
      Emitter<DownloadSyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorDesembolsoDB
        .savePerfilPreInversionCofinanciadorDesembolsosUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Perfiles PreInversion Cofinanciador Rubros',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadPerfilPreInversionCofinanciadorRubros(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorRubro
        .getPerfilPreInversionCofinanciadorRubrosUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async =>
            await savePerfilPreInversionCofinanciadorRubros(data, emit));
  }

  Future<void> savePerfilPreInversionCofinanciadorRubros(
      List<PerfilPreInversionCofinanciadorRubroEntity> data,
      Emitter<DownloadSyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorRubroDB
        .savePerfilPreInversionCofinanciadorRubrosUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Perfiles PreInversion Cofinanciadores',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadPerfilPreInversionCofinanciadores(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await perfilPreInversionCofinanciador
        .getPerfilPreInversionCofinanciadoresUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await savePerfilPreInversionCofinanciador(data, emit));
  }

  Future<void> savePerfilPreInversionCofinanciador(
      List<PerfilPreInversionCofinanciadorEntity> data,
      Emitter<DownloadSyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorDB
        .savePerfilPreInversionCofinanciadoresUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Perfiles PreInversion Consultores',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadPerfilPreInversionConsultores(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await perfilPreInversionConsultor
        .getPerfilPreInversionConsultoresUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await savePerfilPreInversionConsultor(data, emit));
  }

  Future<void> savePerfilPreInversionConsultor(
      List<PerfilPreInversionConsultorEntity> data,
      Emitter<DownloadSyncState> emit) async {
    final result = await perfilPreInversionConsultorDB
        .savePerfilPreInversionConsultoresUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Perfiles PreInversion Precios',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadPerfilPreInversionPrecios(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await perfilPreInversionPrecio
        .getPerfilPreInversionPreciosUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await savePerfilPreInversionPrecios(data, emit));
  }

  Future<void> savePerfilPreInversionPrecios(
      List<PerfilPreInversionPrecioEntity> data,
      Emitter<DownloadSyncState> emit) async {
    final result = await perfilPreInversionPrecioDB
        .savePerfilPreInversionPreciosUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
          title: 'Sincronizando Tipos Discapacidades',
          counter: state.downloadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  Future<void> downloadTiposDiscapacidades(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result =
        await tipoDiscapacidad.getTiposDiscapacidadesUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveTiposDiscapacidades(data, emit));
  }

  Future<void> saveTiposDiscapacidades(List<TipoDiscapacidadEntity> data,
      Emitter<DownloadSyncState> emit) async {
    final result =
        await tipoDiscapacidadDB.saveTiposDiscapacidadesUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {
      /* add(DownloadStatusChanged(state.downloadProgressModel!.copyWith(
            title: 'Sincronizando Veredas',
            counter: state.downloadProgressModel!.counter + 1,
            percent: calculatePercent())));
         */
    });
  }

  /* Future<void> downloadVeredas(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await vereda.getVeredasUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveVeredas(data, emit));
  }

  Future<void> saveVeredas(
      List<VeredaEntity> data, Emitter<DownloadSyncState> emit) async {
    final result = await veredaDB.saveVeredasUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
  } */

  Future<void> getMunicipiosPerfilesDB(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await perfilesDB.getMunicipiosPerfilesUsecaseDB();
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await downloadVeredas(usuario, data, emit));
  }

  Future<void> downloadVeredas(UsuarioEntity usuario, List<String> data,
      Emitter<DownloadSyncState> emit) async {
    final result = await vereda.downloadVeredas(usuario, data);
    return result.fold(
        (failure) => [], (data) async => await saveVeredas(data, emit));
  }

  Future<void> saveVeredas(
      List<VeredaModel> data, Emitter<DownloadSyncState> emit) async {
    final result = await veredaDB.saveVeredasUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
  }
}
