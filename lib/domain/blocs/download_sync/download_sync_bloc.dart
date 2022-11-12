import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/usuario_entity.dart';
import '../../usecases/actividad_economica/actividad_economica_exports.dart';
import '../../usecases/actividad_financiera/actividad_financiera_exports.dart';
import '../../usecases/agrupacion/agrupacion_exports.dart';
import '../../usecases/aliado/aliado_exports.dart';
import '../../usecases/alianza/alianza_exports.dart';
import '../../usecases/beneficiario/beneficiario_exports.dart';
import '../../usecases/beneficiario_alianza/beneficiario_alianza_exports.dart';
import '../../usecases/beneficiario_preinversion/beneficiario_preinversion_exports.dart';
import '../../usecases/cofinanciador/cofinanciador_exports.dart';
import '../../usecases/consultor/consultor_exports.dart';
import '../../usecases/convocatoria/convocatoria_exports.dart';
import '../../usecases/criterio/criterio_exports.dart';
import '../../usecases/departamento/departamento_exports.dart';
import '../../usecases/desembolso/desembolso_exports.dart';
import '../../usecases/estado_civil/estado_civil_exports.dart';
import '../../usecases/estado_visita/estado_visita_exports.dart';
import '../../usecases/frecuencia/frecuencia_exports.dart';
import '../../usecases/genero/genero_exports.dart';
import '../../usecases/grupo_especial/grupo_especial_exports.dart';
import '../../usecases/menu/menu_exports.dart';
import '../../usecases/municipio/municipio_exports.dart';
import '../../usecases/nivel_escolar/nivel_escolar_exports.dart';
import '../../usecases/opcion/opcion_exports.dart';
import '../../usecases/perfil/perfil_exports.dart';
import '../../usecases/producto/producto_exports.dart';
import '../../usecases/residencia/residencia_exports.dart';
import '../../usecases/revision/revision_exports.dart';
import '../../usecases/rubro/rubro_exports.dart';
import '../../usecases/sitio_entrega/sitio_entrega_exports.dart';
import '../../usecases/tipo_actividad_productiva/tipo_actividad_productiva_exports.dart';
import '../../usecases/tipo_calidad/tipo_calidad_exports.dart';
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
  final MenuUsecase menu;
  final MenuUsecaseDB menuDB;

  final ConvocatoriaUsecase convocatoria;
  final ConvocatoriaUsecaseDB convocatoriaDB;

  final TipoProyectoUsecase tipoProyecto;
  final TipoProyectoUsecaseDB tipoProyectoDB;

  final UnidadUsecase unidad;
  final UnidadUsecaseDB unidadDB;

  final PerfilUsecase perfiles;
  final PerfilUsecaseDB perfilesDB;

  final ProductoUsecase productos;
  final ProductoUsecaseDB productosDB;

  final GeneroUsecase generos;
  final GeneroUsecaseDB generosDB;

  final DepartamentoUsecase departamentos;
  final DepartamentoUsecaseDB departamentosDB;

  final MunicipioUsecase municipios;
  final MunicipioUsecaseDB municipiosDB;

  final TipoVisitaUsecase tipoVisita;
  final TipoVisitaUsecaseDB tipoVisitaDB;

  final EstadoVisitaUsecase estadoVisita;
  final EstadoVisitaUsecaseDB estadoVisitaDB;

  final AgrupacionUsecase agrupacion;
  final AgrupacionUsecaseDB agrupacionDB;

  final EstadoCivilUsecase estadoCivil;
  final EstadoCivilUsecaseDB estadoCivilDB;

  final ResidenciaUsecase residencia;
  final ResidenciaUsecaseDB residenciaDB;

  final TipoTenenciaUsecase tipoTenencia;
  final TipoTenenciaUsecaseDB tipoTenenciaDB;

  final NivelEscolarUsecase nivelEscolar;
  final NivelEscolarUsecaseDB nivelEscolarDB;

  final VeredaUsecase vereda;
  final VeredaUsecaseDB veredaDB;

  final AlianzaUsecase alianza;
  final AlianzaUsecaseDB alianzaDB;

  final AliadoUsecase aliado;
  final AliadoUsecaseDB aliadoDB;

  final FrecuenciaUsecase frecuencia;
  final FrecuenciaUsecaseDB frecuenciaDB;

  final BeneficiarioUsecase beneficiario;
  final BeneficiarioUsecaseDB beneficiarioDB;

  final GrupoEspecialUsecase grupoEspecial;
  final GrupoEspecialUsecaseDB grupoEspecialDB;

  final TipoIdentificacionUsecase tipoIdentificacion;
  final TipoIdentificacionUsecaseDB tipoIdentificacionDB;

  final RevisionUsecase revision;
  final RevisionUsecaseDB revisionDB;

  final ConsultorUsecase consultor;
  final ConsultorUsecaseDB consultorDB;

  final TipoEntidadUsecase tipoEntidad;
  final TipoEntidadUsecaseDB tipoEntidadDB;

  final CofinanciadorUsecase cofinanciador;
  final CofinanciadorUsecaseDB cofinanciadorDB;

  final DesembolsoUsecase desembolso;
  final DesembolsoUsecaseDB desembolsoDB;

  final RubroUsecase rubro;
  final RubroUsecaseDB rubroDB;

  final ActividadFinancieraUsecase actividadFinanciera;
  final ActividadFinancieraUsecaseDB actividadFinancieraDB;

  final TipoMovimientoUsecase tipoMovimiento;
  final TipoMovimientoUsecaseDB tipoMovimientoDB;

  final TipoCalidadUsecase tipoCalidad;
  final TipoCalidadUsecaseDB tipoCalidadDB;

  final TipoActividadProductivaUsecase tipoActividadProductiva;
  final TipoActividadProductivaUsecaseDB tipoActividadProductivaDB;

  final ActividadEconomicaUsecase actividadEconomica;
  final ActividadEconomicaUsecaseDB actividadEconomicaDB;

  final BeneficiarioPreinversionUsecase beneficiarioPreinversion;
  final BeneficiarioPreinversionUsecaseDB beneficiarioPreinversionDB;

  final BeneficiarioAlianzaUsecase beneficiarioAlianza;
  final BeneficiarioAlianzaUsecaseDB beneficiarioAlianzaDB;

  final OpcionUsecase opcion;
  final OpcionUsecaseDB opcionDB;

  final CriterioUsecase criterio;
  final CriterioUsecaseDB criterioDB;

  final VisitaUsecase visita;
  final VisitaUsecaseDB visitaDB;

  final SitioEntregaUsecase sitioEntrega;
  final SitioEntregaUsecaseDB sitioEntregaDB;

  DownloadSyncBloc({
    required this.menu,
    required this.menuDB,
    required this.convocatoria,
    required this.convocatoriaDB,
    required this.tipoProyecto,
    required this.tipoProyectoDB,
    required this.unidad,
    required this.unidadDB,
    required this.perfiles,
    required this.perfilesDB,
    required this.productos,
    required this.productosDB,
    required this.generos,
    required this.generosDB,
    required this.departamentos,
    required this.departamentosDB,
    required this.municipios,
    required this.municipiosDB,
    required this.tipoVisita,
    required this.tipoVisitaDB,
    required this.estadoVisita,
    required this.estadoVisitaDB,
    required this.agrupacion,
    required this.agrupacionDB,
    required this.estadoCivil,
    required this.estadoCivilDB,
    required this.residencia,
    required this.residenciaDB,
    required this.tipoTenencia,
    required this.tipoTenenciaDB,
    required this.nivelEscolar,
    required this.nivelEscolarDB,
    required this.vereda,
    required this.veredaDB,
    required this.alianza,
    required this.alianzaDB,
    required this.aliado,
    required this.aliadoDB,
    required this.frecuencia,
    required this.frecuenciaDB,
    required this.beneficiario,
    required this.beneficiarioDB,
    required this.grupoEspecial,
    required this.grupoEspecialDB,
    required this.tipoIdentificacion,
    required this.tipoIdentificacionDB,
    required this.revision,
    required this.revisionDB,
    required this.consultor,
    required this.consultorDB,
    required this.tipoEntidad,
    required this.tipoEntidadDB,
    required this.cofinanciador,
    required this.cofinanciadorDB,
    required this.desembolso,
    required this.desembolsoDB,
    required this.rubro,
    required this.rubroDB,
    required this.actividadFinanciera,
    required this.actividadFinancieraDB,
    required this.tipoMovimiento,
    required this.tipoMovimientoDB,
    required this.tipoCalidad,
    required this.tipoCalidadDB,
    required this.tipoActividadProductiva,
    required this.tipoActividadProductivaDB,
    required this.actividadEconomica,
    required this.actividadEconomicaDB,
    required this.beneficiarioPreinversion,
    required this.beneficiarioPreinversionDB,
    required this.beneficiarioAlianza,
    required this.beneficiarioAlianzaDB,
    required this.opcion,
    required this.opcionDB,
    required this.criterio,
    required this.criterioDB,
    required this.visita,
    required this.visitaDB,
    required this.sitioEntrega,
    required this.sitioEntregaDB,
  }) : super(DownloadSyncInitial()) {
    on<DownloadStarted>((event, emit) async {
      final usuario = event.usuario;

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Menús',
          counter: state.progressModel!.counter + 1)));
      await downloadMenu(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Convocatorias',
          counter: state.progressModel!.counter + 1)));
      await downloadConvocatorias(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Tipos Proyectos',
          counter: state.progressModel!.counter + 1)));
      await downloadTiposProyectos(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Unidades',
          counter: state.progressModel!.counter + 1)));
      await downloadUnidades(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Perfiles',
          counter: state.progressModel!.counter + 1)));
      await downloadPerfiles(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Productos',
          counter: state.progressModel!.counter + 1)));
      await downloadProductos(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Géneros',
          counter: state.progressModel!.counter + 1)));
      await downloadGeneros(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Departamentos',
          counter: state.progressModel!.counter + 1)));
      await downloadDepartamentos(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Municipios',
          counter: state.progressModel!.counter + 1)));
      await downloadMunicipios(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Tipos Visita',
          counter: state.progressModel!.counter + 1)));
      await downloadTiposVisitas(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Estados Visita',
          counter: state.progressModel!.counter + 1)));
      await downloadEstadosVisitas(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Agrupaciones',
          counter: state.progressModel!.counter + 1)));
      await downloadAgrupaciones(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Estados Civiles',
          counter: state.progressModel!.counter + 1)));
      await downloadEstadosCiviles(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Residencias',
          counter: state.progressModel!.counter + 1)));
      await downloadResidencias(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Tipos Tenencia',
          counter: state.progressModel!.counter + 1)));
      await downloadTiposTenencias(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Niveles Escolares',
          counter: state.progressModel!.counter + 1)));
      await downloadNivelesEscolares(usuario, emit);

      /* emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Veredas',
          counter: state.progressModel!.counter + 1)));
      await downloadVeredas(usuario, emit); */

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Alianzas',
          counter: state.progressModel!.counter + 1)));
      await downloadAlianzas(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Aliados',
          counter: state.progressModel!.counter + 1)));
      await downloadAliados(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Frecuencias',
          counter: state.progressModel!.counter + 1)));
      await downloadFrecuencias(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Beneficiarios',
          counter: state.progressModel!.counter + 1)));
      await downloadBeneficiarios(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Grupos Especiales',
          counter: state.progressModel!.counter + 1)));
      await downloadGruposEspeciales(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Tipos de Identificacion',
          counter: state.progressModel!.counter + 1)));
      await downloadTipoIdentificacion(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Revisiones',
          counter: state.progressModel!.counter + 1)));
      await downloadRevisiones(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Consultores',
          counter: state.progressModel!.counter + 1)));
      await downloadConsultores(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Tipos Entidades',
          counter: state.progressModel!.counter + 1)));
      await downloadTiposEntidades(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Cofinanciadores',
          counter: state.progressModel!.counter + 1)));
      await downloadCofinanciadores(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Desembolsos',
          counter: state.progressModel!.counter + 1)));
      await downloadDesembolsos(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Rubros',
          counter: state.progressModel!.counter + 1)));
      await downloadRubros(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Actividades Financieras',
          counter: state.progressModel!.counter + 1)));
      await downloadActividadesFinancieras(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Tipos Movimientos',
          counter: state.progressModel!.counter + 1)));
      await downloadTiposMovimientos(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Tipos Calidades',
          counter: state.progressModel!.counter + 1)));
      await downloadTiposCalidades(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Tipos Actividades Productivas',
          counter: state.progressModel!.counter + 1)));
      await downloadTiposActividadesProductivas(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Actividades Económicas',
          counter: state.progressModel!.counter + 1)));
      await downloadActividadesEconomicas(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Opciones',
          counter: state.progressModel!.counter + 1)));
      await downloadOpciones(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Criterios',
          counter: state.progressModel!.counter + 1)));
      await downloadCriterios(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Visitas',
          counter: state.progressModel!.counter + 1)));
      await downloadVisitas(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Sitios de Entrega',
          counter: state.progressModel!.counter + 1)));
      await downloadSitiosEntregas(usuario, emit);

      /*   emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Beneficiarios Preinversion',
          counter: state.progressModel!.counter + 1)));
      await downloadBeneficiariosPreinversion(usuario, emit);

      emit(DownloadSyncInProgress(state.progressModel!.copyWith(
          title: 'Sincronizando Beneficiarios Alianza',
          counter: state.progressModel!.counter + 1)));
      await downloadBeneficiariosAlianza(usuario, emit); */

      emit(DownloadSyncSuccess());
    });

    on<DownloadSyncError>(
        (event, emit) => emit(DownloadSyncFailure(event.message)));
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> downloadVeredas(
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> downloadBeneficiariosPreinversion(
      UsuarioEntity usuario, Emitter<DownloadSyncState> emit) async {
    final result = await beneficiarioPreinversion
        .getBeneficiariosPreinversionUsecase(usuario);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)),
        (data) async => await saveBeneficiariosPreinversion(data, emit));
  }

  Future<void> saveBeneficiariosPreinversion(
      List<BeneficiarioPreinversionEntity> data,
      Emitter<DownloadSyncState> emit) async {
    final result = await beneficiarioPreinversionDB
        .saveBeneficiariosPreinversionUsecaseDB(data);
    return result.fold(
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
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
        (failure) => add(DownloadSyncError(failure.properties.first)), (_) {});
  }
}
