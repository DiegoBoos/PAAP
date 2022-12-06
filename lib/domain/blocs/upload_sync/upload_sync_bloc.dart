import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paap/domain/usecases/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_exports.dart';

import '../../entities/usuario_entity.dart';
import '../../usecases/aliado/aliado_exports.dart';
import '../../usecases/alianza_beneficiario/alianza_beneficiario_exports.dart';
import '../../usecases/alianza_experiencia_agricola/alianza_experiencia_agricola_exports.dart';
import '../../usecases/alianza_experiencia_pecuaria/alianza_experiencia_pecuaria_exports.dart';
import '../../usecases/beneficiario/beneficiario_exports.dart';
import '../../usecases/evaluacion/evaluacion_exports.dart';
import '../../usecases/evaluacion_respuesta/evaluacion_respuesta_exports.dart';
import '../../usecases/experiencia_agricola/experiencia_agricola_exports.dart';
import '../../usecases/experiencia_pecuaria/experiencia_pecuaria_exports.dart';
import '../../usecases/perfil_beneficiario/perfil_beneficiario_exports.dart';
import '../../usecases/perfil_preinversion_aliado/perfil_preinversion_aliado_exports.dart';
import '../../usecases/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_exports.dart';
import '../../usecases/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_exports.dart';
import '../../usecases/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_exports.dart';
import '../../usecases/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_exports.dart';
import '../../usecases/perfil_preinversion_consultor/perfil_preinversion_consultor_exports.dart';
import '../../usecases/perfil_preinversion_plan_negocio/perfil_preinversion_plan_negocio_exports.dart';
import '../../usecases/perfil_preinversion_precio/perfil_preinversion_precio_exports.dart';
import '../../usecases/visita/visita_exports.dart';

part 'upload_sync_event.dart';
part 'upload_sync_state.dart';

class UploadSyncBloc extends Bloc<UploadSyncEvent, UploadSyncState> {
  final VisitaUsecase visita;
  final VisitaUsecaseDB visitaDB;
  final EvaluacionUsecase evaluacion;
  final EvaluacionUsecaseDB evaluacionDB;
  final BeneficiarioUsecase beneficiario;
  final BeneficiarioUsecaseDB beneficiarioDB;
  final ExperienciaAgricolaUsecase experienciaAgricola;
  final ExperienciaAgricolaUsecaseDB experienciaAgricolaDB;
  final ExperienciaPecuariaUsecase experienciaPecuaria;
  final ExperienciaPecuariaUsecaseDB experienciaPecuariaDB;
  final PerfilBeneficiarioUsecase perfilBeneficiario;
  final PerfilBeneficiarioUsecaseDB perfilBeneficiarioDB;
  final PerfilPreInversionBeneficiarioUsecase perfilPreInversionBeneficiario;
  final PerfilPreInversionBeneficiarioUsecaseDB
      perfilPreInversionBeneficiarioDB;
  final AlianzaBeneficiarioUsecase alianzaBeneficiario;
  final AlianzaBeneficiarioUsecaseDB alianzaBeneficiarioDB;
  final EvaluacionRespuestaUsecase evaluacionRespuesta;
  final EvaluacionRespuestaUsecaseDB evaluacionRespuestaDB;
  final AliadoUsecase aliado;
  final AliadoUsecaseDB aliadoDB;
  final PerfilPreInversionAliadoUsecase perfilPreInversionAliado;
  final PerfilPreInversionAliadoUsecaseDB perfilPreInversionAliadoDB;

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

  final PerfilPreInversionPrecioUsecase perfilPreInversionPrecio;
  final PerfilPreInversionPrecioUsecaseDB perfilPreInversionPrecioDB;

  final PerfilPreInversionPlanNegocioUsecase perfilPreInversionPlanNegocio;
  final PerfilPreInversionPlanNegocioUsecaseDB perfilPreInversionPlanNegocioDB;

  final AlianzaExperienciaAgricolaUsecase alianzaExperienciaAgricola;
  final AlianzaExperienciaAgricolaUsecaseDB alianzaExperienciaAgricolaDB;
  final AlianzaExperienciaPecuariaUsecase alianzaExperienciaPecuaria;
  final AlianzaExperienciaPecuariaUsecaseDB alianzaExperienciaPecuariaDB;

  UploadSyncBloc({
    required this.visita,
    required this.visitaDB,
    required this.evaluacion,
    required this.evaluacionDB,
    required this.evaluacionRespuesta,
    required this.evaluacionRespuestaDB,
    required this.beneficiario,
    required this.beneficiarioDB,
    required this.experienciaAgricola,
    required this.experienciaAgricolaDB,
    required this.experienciaPecuaria,
    required this.experienciaPecuariaDB,
    required this.perfilBeneficiario,
    required this.perfilBeneficiarioDB,
    required this.perfilPreInversionBeneficiario,
    required this.perfilPreInversionBeneficiarioDB,
    required this.alianzaBeneficiario,
    required this.alianzaBeneficiarioDB,
    required this.aliado,
    required this.aliadoDB,
    required this.perfilPreInversionAliado,
    required this.perfilPreInversionAliadoDB,
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
    required this.perfilPreInversionPrecio,
    required this.perfilPreInversionPrecioDB,
    required this.perfilPreInversionPlanNegocio,
    required this.perfilPreInversionPlanNegocioDB,
    required this.alianzaExperienciaAgricola,
    required this.alianzaExperienciaAgricolaDB,
    required this.alianzaExperienciaPecuaria,
    required this.alianzaExperienciaPecuariaDB,
  }) : super(UploadSyncInitial()) {
    on<UploadStarted>((event, emit) async {
      final usuario = event.usuario;

      add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
          title: 'Sincronizando Visitas',
          counter: state.uploadProgressModel!.counter + 1,
          percent: calculatePercent())));
      await uploadVisita(usuario, emit);
    });

    on<UploadStatusChanged>((event, emit) {
      event.progress.counter == 21
          ? emit(UploadSyncSuccess())
          : emit(UploadSyncInProgress(event.progress));
    });

    on<UploadSyncError>(
        (event, emit) => emit(UploadSyncFailure(event.message)));
  }

  double calculatePercent() {
    final counter = state.uploadProgressModel!.counter;
    final total = state.uploadProgressModel!.total;
    final percent = ((counter / total) * 100) / 100;

    return percent;
  }

  // Sync Visita
  Future<void> uploadVisita(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Visitas (Verificando OffLine)',
        counter: 1,
        percent: calculatePercent())));
    final result = await visitaDB.getVisitasProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveVisitasRemote(usuario, data, emit));
  }

  Future<void> saveVisitasRemote(UsuarioEntity usuario, List<VisitaEntity> data,
      Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Visitas (Subiendo Cambios)',
        counter: 1,
        percent: calculatePercent())));
    final result = await visita.saveVisitasUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await downloadVisitas(usuario, emit));
  }

  Future<void> downloadVisitas(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Visitas (Descargando)',
        counter: 1,
        percent: calculatePercent())));
    final result = await visita.getVisitasUsecase(usuario);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveDownloadVisitas(data, emit, usuario));
  }

  Future<void> saveDownloadVisitas(List<VisitaEntity> data,
      Emitter<UploadSyncState> emit, UsuarioEntity usuario) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Visitas (Guardando OffLine)',
        counter: 1,
        percent: calculatePercent())));
    final result = await visitaDB.saveVisitasUsecaseDB(data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (_) async => await uploadEvaluacion(usuario, emit));
  }

  // Sync Evaluacion
  Future<void> uploadEvaluacion(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Evaluaciones (Verificando OffLine)',
        counter: 2,
        percent: calculatePercent())));
    final result = await evaluacionDB.getEvaluacionesProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveEvaluacionesRemote(usuario, data, emit));
  }

  Future<void> saveEvaluacionesRemote(UsuarioEntity usuario,
      List<EvaluacionEntity> data, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Evaluaciones (Subiendo Cambios)',
        counter: 2,
        percent: calculatePercent())));
    final result = await evaluacion.saveEvaluacionesUsecase(usuario, data);
    return result
        .fold((failure) => add(UploadSyncError(failure.properties.first)),
            (data) async {
      await evaluacionRespuestaDB
          .updateRespuestaRemoteEvaluacionIdUsecaseDB(data);
      await downloadEvaluaciones(usuario, emit);
    });
  }

  Future<void> downloadEvaluaciones(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Evaluaciones (Descargando)',
        counter: 2,
        percent: calculatePercent())));
    final result = await evaluacion.getEvaluacionesUsecase(usuario);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveDownloadEvaluaciones(data, emit, usuario));
  }

  Future<void> saveDownloadEvaluaciones(List<EvaluacionEntity> data,
      Emitter<UploadSyncState> emit, UsuarioEntity usuario) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Evaluaciones (Guardando OffLine)',
        counter: 2,
        percent: calculatePercent())));
    final result = await evaluacionDB.saveEvaluacionesUsecaseDB(data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) async {
      await uploadEvaluacionRespuesta(usuario, emit);
    });
  }

  // Sync Evaluaciones Respuestas
  Future<void> uploadEvaluacionRespuesta(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Evaluacion Respuesta (Verificando OffLine)',
        counter: 3,
        percent: calculatePercent())));
    final result = await evaluacionRespuestaDB
        .getEvaluacionesRespuestasProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await saveEvaluacionesRespuestasRemote(usuario, data, emit));
  }

  Future<void> saveEvaluacionesRespuestasRemote(
      UsuarioEntity usuario,
      List<EvaluacionRespuestaEntity> data,
      Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Evaluacion Respuesta (Subiendo Cambios)',
        counter: 3,
        percent: calculatePercent())));
    final result = await evaluacionRespuesta.saveEvaluacionesRespuestasUsecase(
        usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await downloadEvaluacionesRespuestas(usuario, emit));
  }

  Future<void> downloadEvaluacionesRespuestas(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Evaluacion Respuesta (Descargando)',
        counter: 3,
        percent: calculatePercent())));
    final result =
        await evaluacionRespuesta.getEvaluacionesRespuestasUsecase(usuario);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await saveDownloadEvaluacionesRespuestas(data, emit, usuario));
  }

  Future<void> saveDownloadEvaluacionesRespuestas(
      List<EvaluacionRespuestaEntity> data,
      Emitter<UploadSyncState> emit,
      UsuarioEntity usuario) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Evaluacion Respuesta (Guardando OffLine)',
        counter: 3,
        percent: calculatePercent())));
    final result =
        await evaluacionRespuestaDB.saveEvaluacionesRespuestasUsecaseDB(data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (_) async => await uploadBeneficiario(usuario, emit));
  }

  // Sync Beneficiario
  Future<void> uploadBeneficiario(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Beneficiarios (Verificando OffLine)',
        counter: 4,
        percent: calculatePercent())));
    final result = await beneficiarioDB.getBeneficiariosProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveBeneficiariosRemote(usuario, data, emit));
  }

  Future<void> saveBeneficiariosRemote(UsuarioEntity usuario,
      List<BeneficiarioEntity> data, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Beneficiarios (Subiendo Cambios)',
        counter: 4,
        percent: calculatePercent())));
    final result = await beneficiario.saveBeneficiariosUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await downloadBeneficiarios(usuario, emit));
  }

  Future<void> downloadBeneficiarios(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Beneficiarios (Descargando)',
        counter: 4,
        percent: calculatePercent())));
    final result = await beneficiario.getBeneficiariosUsecase(usuario);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveDownloadBeneficiarios(data, emit, usuario));
  }

  Future<void> saveDownloadBeneficiarios(List<BeneficiarioEntity> data,
      Emitter<UploadSyncState> emit, UsuarioEntity usuario) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Beneficiarios (Guardando OffLine)',
        counter: 4,
        percent: calculatePercent())));
    final result = await beneficiarioDB.saveBeneficiariosUsecaseDB(data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (_) async => await uploadExperienciaAgricola(usuario, emit));
  }

  // Sync Experiencias Agrícolas
  Future<void> uploadExperienciaAgricola(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Experiencias Agricolas (Verificando OffLine)',
        counter: 5,
        percent: calculatePercent())));
    final result = await experienciaAgricolaDB
        .getExperienciasAgricolasProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await saveExperienciasAgricolasRemote(usuario, data, emit));
  }

  Future<void> saveExperienciasAgricolasRemote(
      UsuarioEntity usuario,
      List<ExperienciaAgricolaEntity> data,
      Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Experiencias Agricolas (Subiendo Cambios)',
        counter: 5,
        percent: calculatePercent())));
    final result = await experienciaAgricola.saveExperienciasAgricolasUsecase(
        usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await downloadExperienciasAgricolas(usuario, emit));
  }

  Future<void> downloadExperienciasAgricolas(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Experiencias Agricolas (Descargando)',
        counter: 5,
        percent: calculatePercent())));
    final result =
        await experienciaAgricola.getExperienciasAgricolasUsecase(usuario);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await saveDownloadExperienciasAgricolas(data, emit, usuario));
  }

  Future<void> saveDownloadExperienciasAgricolas(
      List<ExperienciaAgricolaEntity> data,
      Emitter<UploadSyncState> emit,
      UsuarioEntity usuario) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Experiencias Agricolas (Guardando OffLine)',
        counter: 5,
        percent: calculatePercent())));
    final result =
        await experienciaAgricolaDB.saveExperienciasAgricolasUsecaseDB(data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (_) async => await uploadExperienciaPecuaria(usuario, emit));
  }

  // Sync Experiencias Pecuarias
  Future<void> uploadExperienciaPecuaria(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Experiencias Pecuarias (Verificando OffLine)',
        counter: 6,
        percent: calculatePercent())));
    final result = await experienciaPecuariaDB
        .getExperienciasPecuariasProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await saveExperienciasPecuariasRemote(usuario, data, emit));
  }

  Future<void> saveExperienciasPecuariasRemote(
      UsuarioEntity usuario,
      List<ExperienciaPecuariaEntity> data,
      Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Experiencias Pecuarias (Subiendo Cambios)',
        counter: 6,
        percent: calculatePercent())));
    final result = await experienciaPecuaria.saveExperienciasPecuariasUsecase(
        usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await downloadExperienciasPecuarias(usuario, emit));
  }

  Future<void> downloadExperienciasPecuarias(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Experiencias Pecuarias (Descargando)',
        counter: 6,
        percent: calculatePercent())));
    final result =
        await experienciaPecuaria.getExperienciasPecuariasUsecase(usuario);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await saveDownloadExperienciasPecuarias(data, emit, usuario));
  }

  Future<void> saveDownloadExperienciasPecuarias(
      List<ExperienciaPecuariaEntity> data,
      Emitter<UploadSyncState> emit,
      UsuarioEntity usuario) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Experiencias Pecuarias (Guardando OffLine)',
        counter: 6,
        percent: calculatePercent())));
    final result =
        await experienciaPecuariaDB.saveExperienciasPecuariasUsecaseDB(data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (_) async => await uploadPerfilBeneficiario(usuario, emit));
  }

  // Sync Perfil Beneficiario
  Future<void> uploadPerfilBeneficiario(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Perfil Beneficiario (Verificando OffLine)',
        counter: 7,
        percent: calculatePercent())));
    final result = await perfilBeneficiarioDB
        .getPerfilesBeneficiariosProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await savePerfilesBeneficiariosRemote(usuario, data, emit));
  }

  Future<void> savePerfilesBeneficiariosRemote(
      UsuarioEntity usuario,
      List<PerfilBeneficiarioEntity> data,
      Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Perfil Beneficiario (Subiendo Cambios)',
        counter: 7,
        percent: calculatePercent())));
    final result = await perfilBeneficiario.savePerfilesBeneficiariosUsecase(
        usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await downloadPerfilesBeneficiarios(usuario, emit));
  }

  Future<void> downloadPerfilesBeneficiarios(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Perfil Beneficiario (Descargando)',
        counter: 7,
        percent: calculatePercent())));
    final result =
        await perfilBeneficiario.getPerfilBeneficiariosUsecase(usuario);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await saveDownloadPerfilesBeneficiarios(data, emit, usuario));
  }

  Future<void> saveDownloadPerfilesBeneficiarios(
      List<PerfilBeneficiarioEntity> data,
      Emitter<UploadSyncState> emit,
      UsuarioEntity usuario) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Perfil Beneficiario (Guardando OffLine)',
        counter: 7,
        percent: calculatePercent())));
    final result =
        await perfilBeneficiarioDB.savePerfilBeneficiariosUsecaseDB(data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (_) async => await uploadAlianzaBeneficiario(usuario, emit));
  }

  // Sync Alianza Beneficiario
  Future<void> uploadAlianzaBeneficiario(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Alianza Beneficiario (Verificando OffLine)',
        counter: 8,
        percent: calculatePercent())));
    final result = await alianzaBeneficiarioDB
        .getAlianzasBeneficiariosProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await saveAlianzasBeneficiariosRemote(usuario, data, emit));
  }

  Future<void> saveAlianzasBeneficiariosRemote(
      UsuarioEntity usuario,
      List<AlianzaBeneficiarioEntity> data,
      Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Alianza Beneficiario (Subiendo Cambios)',
        counter: 8,
        percent: calculatePercent())));
    final result = await alianzaBeneficiario.saveAlianzasBeneficiariosUsecase(
        usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await downloadAlianzasBeneficiarios(usuario, emit));
  }

  Future<void> downloadAlianzasBeneficiarios(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Alianza Beneficiario (Descargando)',
        counter: 8,
        percent: calculatePercent())));
    final result =
        await alianzaBeneficiario.getAlianzasBeneficiariosUsecase(usuario);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await saveDownloadAlianzasBeneficiarios(data, emit, usuario));
  }

  Future<void> saveDownloadAlianzasBeneficiarios(
      List<AlianzaBeneficiarioEntity> data,
      Emitter<UploadSyncState> emit,
      UsuarioEntity usuario) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Alianza Beneficiario (Guardando OffLine)',
        counter: 8,
        percent: calculatePercent())));
    final result =
        await alianzaBeneficiarioDB.saveAlianzasBeneficiariosUsecaseDB(data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (_) async => await uploadPerfilPreInversionBeneficiario(usuario, emit));
  }

  // Sync Perfil PreInversion Beneficiario
  Future<void> uploadPerfilPreInversionBeneficiario(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title:
            'Sincronizando PerfilPreInversion Beneficiario (Verificando OffLine)',
        counter: 9,
        percent: calculatePercent())));
    final result = await perfilPreInversionBeneficiarioDB
        .getPerfilesPreInversionesBeneficiariosProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await savePerfilesPreInversionesBeneficiariosRemote(
            usuario, data, emit));
  }

  Future<void> savePerfilesPreInversionesBeneficiariosRemote(
      UsuarioEntity usuario,
      List<PerfilPreInversionBeneficiarioEntity> data,
      Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title:
            'Sincronizando PerfilPreInversion Beneficiario (Subiendo Cambios)',
        counter: 9,
        percent: calculatePercent())));
    final result = await perfilPreInversionBeneficiario
        .savePerfilesPreInversionesBeneficiariosUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await downloadPerfilesPreInversionesBeneficiarios(usuario, emit));
  }

  Future<void> downloadPerfilesPreInversionesBeneficiarios(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando PerfilPreInversion Beneficiario (Descargando)',
        counter: 9,
        percent: calculatePercent())));
    final result = await perfilPreInversionBeneficiario
        .getPerfilPreInversionBeneficiariosUsecase(usuario);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveDownloadPerfilesPreInversionesBeneficiarios(
            data, emit, usuario));
  }

  Future<void> saveDownloadPerfilesPreInversionesBeneficiarios(
      List<PerfilPreInversionBeneficiarioEntity> data,
      Emitter<UploadSyncState> emit,
      UsuarioEntity usuario) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title:
            'Sincronizando PerfilPreInversion Beneficiario (Guardando OffLine)',
        counter: 9,
        percent: calculatePercent())));
    final result = await perfilPreInversionBeneficiarioDB
        .savePerfilPreInversionBeneficiariosUsecaseDB(data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (_) async => await uploadAliado(usuario, emit));
  }

  // Sync Aliado
  Future<void> uploadAliado(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Aliados (Verificando OffLine)',
        counter: 10,
        percent: calculatePercent())));
    final result = await aliadoDB.getAliadosProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveAliadosRemote(usuario, data, emit));
  }

  Future<void> saveAliadosRemote(UsuarioEntity usuario, List<AliadoEntity> data,
      Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Aliados (Subiendo Cambios)',
        counter: 10,
        percent: calculatePercent())));
    final result = await aliado.saveAliadosUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await downloadAliados(usuario, emit));
  }

  Future<void> downloadAliados(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Aliados (Descargando)',
        counter: 10,
        percent: calculatePercent())));
    final result = await aliado.getAliadosUsecase(usuario);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveDownloadAliados(data, emit, usuario));
  }

  Future<void> saveDownloadAliados(List<AliadoEntity> data,
      Emitter<UploadSyncState> emit, UsuarioEntity usuario) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando Aliados (Guardando OffLine)',
        counter: 10,
        percent: calculatePercent())));
    final result = await aliadoDB.saveAliadosUsecaseDB(data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (_) async => await uploadPerfilPreInversionAliado(usuario, emit));
  }

  // Sync Perfil PreInversion Aliado
  Future<void> uploadPerfilPreInversionAliado(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando PerfilPreInversion Aliado (Verificando OffLine)',
        counter: 11,
        percent: calculatePercent())));
    final result = await perfilPreInversionAliadoDB
        .getPerfilesPreInversionesAliadosProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await savePerfilesPreInversionesAliadosRemote(usuario, data, emit));
  }

  Future<void> savePerfilesPreInversionesAliadosRemote(
      UsuarioEntity usuario,
      List<PerfilPreInversionAliadoEntity> data,
      Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando PerfilPreInversion Aliado (Subiendo Cambios)',
        counter: 11,
        percent: calculatePercent())));
    final result = await perfilPreInversionAliado
        .savePerfilesPreInversionesAliadosUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await downloadPerfilesPreInversionesAliados(usuario, emit));
  }

  Future<void> downloadPerfilesPreInversionesAliados(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando PerfilPreInversion Aliado (Descargando)',
        counter: 11,
        percent: calculatePercent())));
    final result = await perfilPreInversionAliado
        .getPerfilPreInversionAliadosUsecase(usuario);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveDownloadPerfilesPreInversionesAliados(
            data, emit, usuario));
  }

  Future<void> saveDownloadPerfilesPreInversionesAliados(
      List<PerfilPreInversionAliadoEntity> data,
      Emitter<UploadSyncState> emit,
      UsuarioEntity usuario) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando PerfilPreInversion Aliado (Guardando OffLine)',
        counter: 11,
        percent: calculatePercent())));
    final result = await perfilPreInversionAliadoDB
        .savePerfilPreInversionAliadosUsecaseDB(data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (_) async =>
            await uploadPerfilPreInversionCofinanciador(usuario, emit));
  }

  // Sync Perfil PreInversion Cofinanciador
  Future<void> uploadPerfilPreInversionCofinanciador(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title:
            'Sincronizando PerfilPreInversion Cofinanciador (Verificando OffLine)',
        counter: 12,
        percent: calculatePercent())));
    final result = await perfilPreInversionCofinanciadorDB
        .getPerfilesPreInversionesCofinanciadoresProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await savePerfilesPreInversionesCofinanciadoresRemote(
            usuario, data, emit));
  }

  Future<void> savePerfilesPreInversionesCofinanciadoresRemote(
      UsuarioEntity usuario,
      List<PerfilPreInversionCofinanciadorEntity> data,
      Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title:
            'Sincronizando PerfilPreInversion Cofinanciador (Subiendo Cambios)',
        counter: 12,
        percent: calculatePercent())));
    final result = await perfilPreInversionCofinanciador
        .savePerfilesPreInversionesCofinanciadoresUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await downloadPerfilesPreInversionesCofinanciadores(usuario, emit));
  }

  Future<void> downloadPerfilesPreInversionesCofinanciadores(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando PerfilPreInversion Cofinanciador (Descargando)',
        counter: 12,
        percent: calculatePercent())));
    final result = await perfilPreInversionCofinanciador
        .getPerfilPreInversionCofinanciadoresUsecase(usuario);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveDownloadPerfilesPreInversionesCofinanciadores(
            data, emit, usuario));
  }

  Future<void> saveDownloadPerfilesPreInversionesCofinanciadores(
      List<PerfilPreInversionCofinanciadorEntity> data,
      Emitter<UploadSyncState> emit,
      UsuarioEntity usuario) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title:
            'Sincronizando PerfilPreInversion Cofinanciador (Guardando OffLine)',
        counter: 12,
        percent: calculatePercent())));
    final result = await perfilPreInversionCofinanciadorDB
        .savePerfilesPreInversionesCofinanciadoresUsecaseDB(data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (_) async =>
            await uploadPerfilPreInversionCofinanciadorActividadFinanciera(
                usuario, emit));
  }

  // Sync Perfil PreInversion Cofinanciador ActividadFinanciera
  Future<void> uploadPerfilPreInversionCofinanciadorActividadFinanciera(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title:
            'Sincronizando PerfilPreInversion Cofinanciador ActividadFinanciera (Verificando OffLine)',
        counter: 13,
        percent: calculatePercent())));
    final result = await perfilPreInversionCofinanciadorActividadFinancieraDB
        .getPerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await savePerfilesPreInversionesCofinanciadoresActividadesFinancierasRemote(
                usuario, data, emit));
  }

  Future<void>
      savePerfilesPreInversionesCofinanciadoresActividadesFinancierasRemote(
          UsuarioEntity usuario,
          List<PerfilPreInversionCofinanciadorActividadFinancieraEntity> data,
          Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title:
            'Sincronizando PerfilPreInversion Cofinanciador ActividadFinanciera(Subiendo Cambios)',
        counter: 13,
        percent: calculatePercent())));
    final result = await perfilPreInversionCofinanciadorActividadFinanciera
        .savePerfilesPreInversionesCofinanciadoresActividadesFinancierasUsecase(
            usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await downloadPerfilesPreInversionesCofinanciadoresActividadesFinancieras(
                usuario, emit));
  }

  Future<void>
      downloadPerfilesPreInversionesCofinanciadoresActividadesFinancieras(
          UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title:
            'Sincronizando PerfilPreInversion Cofinanciador ActividadFinanciera(Descargando)',
        counter: 13,
        percent: calculatePercent())));
    final result = await perfilPreInversionCofinanciadorActividadFinanciera
        .getPerfilPreInversionCofinanciadorActividadesFinancierasUsecase(
            usuario);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await saveDownloadPerfilesPreInversionesCofinanciadoresActividadesFinancieras(
                data, emit, usuario));
  }

  Future<void>
      saveDownloadPerfilesPreInversionesCofinanciadoresActividadesFinancieras(
          List<PerfilPreInversionCofinanciadorActividadFinancieraEntity> data,
          Emitter<UploadSyncState> emit,
          UsuarioEntity usuario) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title:
            'Sincronizando PerfilPreInversion Cofinanciador ActividadFinanciera(Guardando OffLine)',
        counter: 13,
        percent: calculatePercent())));
    final result = await perfilPreInversionCofinanciadorActividadFinancieraDB
        .savePerfilPreInversionCofinanciadorActividadesFinancierasUsecaseDB(
            data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (_) async => await uploadPerfilPreInversionCofinanciadorDesembolso(
            usuario, emit));
  }

  // Sync Perfil PreInversion Cofinanciador Desembolso
  Future<void> uploadPerfilPreInversionCofinanciadorDesembolso(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title:
            'Sincronizando PerfilPreInversion Cofinanciador Desembolso (Verificando OffLine)',
        counter: 14,
        percent: calculatePercent())));
    final result = await perfilPreInversionCofinanciadorDesembolsoDB
        .getPerfilesPreInversionesCofinanciadoresDesembolsosProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await savePerfilesPreInversionesCofinanciadoresDesembolsosRemote(
                usuario, data, emit));
  }

  Future<void> savePerfilesPreInversionesCofinanciadoresDesembolsosRemote(
      UsuarioEntity usuario,
      List<PerfilPreInversionCofinanciadorDesembolsoEntity> data,
      Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title:
            'Sincronizando PerfilPreInversion Cofinanciador Desembolso(Subiendo Cambios)',
        counter: 14,
        percent: calculatePercent())));
    final result = await perfilPreInversionCofinanciadorDesembolso
        .savePerfilesPreInversionesCofinanciadoresDesembolsosUsecase(
            usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await downloadPerfilesPreInversionesCofinanciadoresDesembolsos(
                usuario, emit));
  }

  Future<void> downloadPerfilesPreInversionesCofinanciadoresDesembolsos(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title:
            'Sincronizando PerfilPreInversion Cofinanciador Desembolso(Descargando)',
        counter: 14,
        percent: calculatePercent())));
    final result = await perfilPreInversionCofinanciadorDesembolso
        .getPerfilPreInversionCofinanciadorDesembolsosUsecase(usuario);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await saveDownloadPerfilesPreInversionesCofinanciadoresDesembolsos(
                data, emit, usuario));
  }

  Future<void> saveDownloadPerfilesPreInversionesCofinanciadoresDesembolsos(
      List<PerfilPreInversionCofinanciadorDesembolsoEntity> data,
      Emitter<UploadSyncState> emit,
      UsuarioEntity usuario) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title:
            'Sincronizando PerfilPreInversion Cofinanciador Desembolso(Guardando OffLine)',
        counter: 14,
        percent: calculatePercent())));
    final result = await perfilPreInversionCofinanciadorDesembolsoDB
        .savePerfilPreInversionCofinanciadorDesembolsosUsecaseDB(data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (_) async =>
            await uploadPerfilPreInversionCofinanciadorRubro(usuario, emit));
  }

  // Sync Perfil PreInversion Cofinanciador Rubro
  Future<void> uploadPerfilPreInversionCofinanciadorRubro(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title:
            'Sincronizando PerfilPreInversion Cofinanciador Rubro (Verificando OffLine)',
        counter: 15,
        percent: calculatePercent())));
    final result = await perfilPreInversionCofinanciadorRubroDB
        .getPerfilesPreInversionesCofinanciadoresRubrosProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await savePerfilesPreInversionesCofinanciadoresRubrosRemote(
                usuario, data, emit));
  }

  Future<void> savePerfilesPreInversionesCofinanciadoresRubrosRemote(
      UsuarioEntity usuario,
      List<PerfilPreInversionCofinanciadorRubroEntity> data,
      Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title:
            'Sincronizando PerfilPreInversion Cofinanciador Rubro(Subiendo Cambios)',
        counter: 15,
        percent: calculatePercent())));
    final result = await perfilPreInversionCofinanciadorRubro
        .savePerfilesPreInversionesCofinanciadoresRubrosUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await downloadPerfilesPreInversionesCofinanciadoresRubros(
                usuario, emit));
  }

  Future<void> downloadPerfilesPreInversionesCofinanciadoresRubros(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title:
            'Sincronizando PerfilPreInversion Cofinanciador Rubro(Descargando)',
        counter: 15,
        percent: calculatePercent())));
    final result = await perfilPreInversionCofinanciadorRubro
        .getPerfilPreInversionCofinanciadorRubrosUsecase(usuario);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await saveDownloadPerfilesPreInversionesCofinanciadoresRubros(
                data, emit, usuario));
  }

  Future<void> saveDownloadPerfilesPreInversionesCofinanciadoresRubros(
      List<PerfilPreInversionCofinanciadorRubroEntity> data,
      Emitter<UploadSyncState> emit,
      UsuarioEntity usuario) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title:
            'Sincronizando PerfilPreInversion Cofinanciador Rubro(Guardando OffLine)',
        counter: 15,
        percent: calculatePercent())));
    final result = await perfilPreInversionCofinanciadorRubroDB
        .savePerfilPreInversionCofinanciadorRubrosUsecaseDB(data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (_) async => await uploadPerfilPreInversionConsultor(usuario, emit));
  }

  // Sync Perfil PreInversion Consultor
  Future<void> uploadPerfilPreInversionConsultor(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title:
            'Sincronizando PerfilPreInversion Consultor (Verificando OffLine)',
        counter: 16,
        percent: calculatePercent())));
    final result = await perfilPreInversionConsultorDB
        .getPerfilesPreInversionesConsultoresProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await savePerfilesPreInversionesConsultoresRemote(
            usuario, data, emit));
  }

  Future<void> savePerfilesPreInversionesConsultoresRemote(
      UsuarioEntity usuario,
      List<PerfilPreInversionConsultorEntity> data,
      Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando PerfilPreInversion Consultor(Subiendo Cambios)',
        counter: 16,
        percent: calculatePercent())));
    final result = await perfilPreInversionConsultor
        .savePerfilesPreInversionesConsultoresUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await downloadPerfilesPreInversionesConsultores(usuario, emit));
  }

  Future<void> downloadPerfilesPreInversionesConsultores(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando PerfilPreInversion Consultor(Descargando)',
        counter: 16,
        percent: calculatePercent())));
    final result = await perfilPreInversionConsultor
        .getPerfilPreInversionConsultoresUsecase(usuario);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveDownloadPerfilesPreInversionesConsultores(
            data, emit, usuario));
  }

  Future<void> saveDownloadPerfilesPreInversionesConsultores(
      List<PerfilPreInversionConsultorEntity> data,
      Emitter<UploadSyncState> emit,
      UsuarioEntity usuario) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando PerfilPreInversion Consultor(Guardando OffLine)',
        counter: 16,
        percent: calculatePercent())));
    final result = await perfilPreInversionConsultorDB
        .savePerfilPreInversionConsultoresUsecaseDB(data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (_) async => await uploadPerfilPreInversionPrecio(usuario, emit));
  }

  // Sync Perfil PreInversion Precio
  Future<void> uploadPerfilPreInversionPrecio(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando PerfilPreInversion Precio (Verificando OffLine)',
        counter: 17,
        percent: calculatePercent())));
    final result = await perfilPreInversionPrecioDB
        .getPerfilesPreInversionesPreciosProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await savePerfilesPreInversionesPreciosRemote(usuario, data, emit));
  }

  Future<void> savePerfilesPreInversionesPreciosRemote(
      UsuarioEntity usuario,
      List<PerfilPreInversionPrecioEntity> data,
      Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando PerfilPreInversion Precio(Subiendo Cambios)',
        counter: 17,
        percent: calculatePercent())));
    final result = await perfilPreInversionPrecio
        .savePerfilesPreInversionesPreciosUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await downloadPerfilesPreInversionesPrecios(usuario, emit));
  }

  Future<void> downloadPerfilesPreInversionesPrecios(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando PerfilPreInversion Precio(Descargando)',
        counter: 17,
        percent: calculatePercent())));
    final result = await perfilPreInversionPrecio
        .getPerfilPreInversionPreciosUsecase(usuario);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveDownloadPerfilesPreInversionesPrecios(
            data, emit, usuario));
  }

  Future<void> saveDownloadPerfilesPreInversionesPrecios(
      List<PerfilPreInversionPrecioEntity> data,
      Emitter<UploadSyncState> emit,
      UsuarioEntity usuario) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando PerfilPreInversion Precio(Guardando OffLine)',
        counter: 17,
        percent: calculatePercent())));
    final result = await perfilPreInversionPrecioDB
        .savePerfilPreInversionPreciosUsecaseDB(data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (_) async => await uploadPerfilPreInversionPlanNegocio(usuario, emit));
  }

  // Sync Perfil PreInversion PlanNegocio
  Future<void> uploadPerfilPreInversionPlanNegocio(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title:
            'Sincronizando PerfilPreInversion PlanNegocio (Verificando OffLine)',
        counter: 18,
        percent: calculatePercent())));
    final result = await perfilPreInversionPlanNegocioDB
        .getPerfilPreInversionplanesNegociosUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await savePerfilesPreInversionesPlanNegociosRemote(
            usuario, data!, emit));
  }

  Future<void> savePerfilesPreInversionesPlanNegociosRemote(
      UsuarioEntity usuario,
      List<PerfilPreInversionPlanNegocioEntity> data,
      Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando PerfilPreInversion PlanNegocio(Subiendo Cambios)',
        counter: 18,
        percent: calculatePercent())));
    final result = await perfilPreInversionPlanNegocio
        .savePerfilesPreInversionesplanesNegociosUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await downloadPerfilesPreInversionesPlanNegocios(usuario, emit));
  }

  Future<void> downloadPerfilesPreInversionesPlanNegocios(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando PerfilPreInversion PlanNegocio(Descargando)',
        counter: 18,
        percent: calculatePercent())));
    final result = await perfilPreInversionPlanNegocio
        .getPerfilPreInversionplanesNegociosUsecase(usuario);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveDownloadPerfilesPreInversionesPlanNegocioes(
            data, emit, usuario));
  }

  Future<void> saveDownloadPerfilesPreInversionesPlanNegocioes(
      List<PerfilPreInversionPlanNegocioEntity> data,
      Emitter<UploadSyncState> emit,
      UsuarioEntity usuario) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title:
            'Sincronizando PerfilPreInversion PlanNegocio(Guardando OffLine)',
        counter: 18,
        percent: calculatePercent())));
    final result = await perfilPreInversionPlanNegocioDB
        .savePerfilPreInversionplanesNegociosUsecaseDB(data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (_) async => uploadAlianzaExperienciaAgricola(usuario, emit));
  }

  // Sync Alianza Experiencias Agrícolas
  Future<void> uploadAlianzaExperienciaAgricola(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title:
            'Sincronizando AlianzaExperiencias Agricolas (Verificando OffLine)',
        counter: 19,
        percent: calculatePercent())));
    final result = await alianzaExperienciaAgricolaDB
        .getAlianzasExperienciasAgricolasProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await saveAlianzaExperienciasAgricolasRemote(usuario, data, emit));
  }

  Future<void> saveAlianzaExperienciasAgricolasRemote(
      UsuarioEntity usuario,
      List<AlianzaExperienciaAgricolaEntity> data,
      Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando AlianzaExperiencias Agricolas (Subiendo Cambios)',
        counter: 19,
        percent: calculatePercent())));
    final result = await alianzaExperienciaAgricola
        .saveAlianzasExperienciasAgricolasUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await downloadAlianzaExperienciasAgricolas(usuario, emit));
  }

  Future<void> downloadAlianzaExperienciasAgricolas(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando AlianzaExperiencias Agricolas (Descargando)',
        counter: 19,
        percent: calculatePercent())));
    final result = await alianzaExperienciaAgricola
        .getAlianzasExperienciasAgricolasUsecase(usuario);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveDownloadAlianzaExperienciasAgricolas(
            data, emit, usuario));
  }

  Future<void> saveDownloadAlianzaExperienciasAgricolas(
      List<AlianzaExperienciaAgricolaEntity> data,
      Emitter<UploadSyncState> emit,
      UsuarioEntity usuario) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title:
            'Sincronizando AlianzaExperiencias Agricolas (Guardando OffLine)',
        counter: 19,
        percent: calculatePercent())));
    final result = await alianzaExperienciaAgricolaDB
        .saveAlianzasExperienciasAgricolasUsecaseDB(data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (_) async => await uploadAlianzaExperienciaPecuaria(usuario, emit));
  }

  // Sync Alianzas Experiencias Pecuarias
  Future<void> uploadAlianzaExperienciaPecuaria(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title:
            'Sincronizando AlianzaExperiencias Pecuarias (Verificando OffLine)',
        counter: 20,
        percent: calculatePercent())));
    final result = await alianzaExperienciaPecuariaDB
        .getAlianzasExperienciasPecuariasProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await saveAlianzaExperienciasPecuariasRemote(usuario, data, emit));
  }

  Future<void> saveAlianzaExperienciasPecuariasRemote(
      UsuarioEntity usuario,
      List<AlianzaExperienciaPecuariaEntity> data,
      Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando AlianzaExperiencias Pecuarias (Subiendo Cambios)',
        counter: 20,
        percent: calculatePercent())));
    final result = await alianzaExperienciaPecuaria
        .saveAlianzasExperienciasPecuariasUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await downloadAlianzaExperienciasPecuarias(usuario, emit));
  }

  Future<void> downloadAlianzaExperienciasPecuarias(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title: 'Sincronizando AlianzaExperiencias Pecuarias (Descargando)',
        counter: 20,
        percent: calculatePercent())));
    final result = await alianzaExperienciaPecuaria
        .getAlianzasExperienciasPecuariasUsecase(usuario);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveDownloadAlianzaExperienciasPecuarias(
            data, emit, usuario));
  }

  Future<void> saveDownloadAlianzaExperienciasPecuarias(
      List<AlianzaExperienciaPecuariaEntity> data,
      Emitter<UploadSyncState> emit,
      UsuarioEntity usuario) async {
    add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
        title:
            'Sincronizando AlianzaExperiencias Pecuarias (Guardando OffLine)',
        counter: 20,
        percent: calculatePercent())));
    final result = await alianzaExperienciaPecuariaDB
        .saveAlianzasExperienciasPecuariasUsecaseDB(data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (_) async => add(UploadStatusChanged(state.uploadProgressModel!
            .copyWith(
                title: 'Sincronización Completada',
                counter: state.uploadProgressModel!.counter + 1,
                percent: calculatePercent()))));
  }
  /* Future<void> updateVisitasProduccion(UsuarioEntity usuario,
      List<VisitaEntity> data, Emitter<UploadSyncState> emit) async {
    final result = await visitaDB.updateVisitasProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
  } */

  /* Future<void> updateEvaluacionesProduccion(UsuarioEntity usuario,
      List<EvaluacionEntity> data, Emitter<UploadSyncState> emit) async {
    final result =
        await evaluacionDB.updateEvaluacionesProduccionUsecaseDB(data);
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await getRemoteEvaluacionesNuevas(usuario, data));
  } */

/*   Future<void> saveAliados(UsuarioEntity usuario, List<AliadoEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await aliado.saveAliadosUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await updateAliadosProduccion(usuario, data, emit));
  }

  Future<void> saveBeneficiarios(UsuarioEntity usuario,
      List<BeneficiarioEntity> data, Emitter<UploadSyncState> emit) async {
    final result = await beneficiario.saveBeneficiariosUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await updateBeneficiariosProduccion(usuario, data, emit));
  } */

  /* Future<void> saveEvaluacionesRespuestas(
      UsuarioEntity usuario,
      List<EvaluacionRespuestaEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await evaluacionRespuesta.saveEvaluacionesRespuestasUsecase(
        usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await updateEvaluacionesRespuestasProduccion(usuario, data, emit));
  } */

  /* Future<void> saveExperienciasAgricolas(
      UsuarioEntity usuario,
      List<ExperienciaAgricolaEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await experienciaAgricola.saveExperienciasAgricolasUsecase(
        usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await updateExperienciasAgricolasProduccion(usuario, data, emit));
  }

  Future<void> saveExperienciasPecuarias(
      UsuarioEntity usuario,
      List<ExperienciaPecuariaEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await experienciaPecuaria.saveExperienciasPecuariasUsecase(
        usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await updateExperienciasPecuariasProduccion(usuario, data, emit));
  }

  Future<void> savePerfilesBeneficiarios(
      UsuarioEntity usuario,
      List<PerfilBeneficiarioEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await perfilBeneficiario.savePerfilesBeneficiariosUsecase(
        usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await updatePerfilesBeneficiariosProduccion(usuario, data, emit));
  }

  Future<void> savePerfilesPreInversionesAliados(
      UsuarioEntity usuario,
      List<PerfilPreInversionAliadoEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionAliado
        .savePerfilesPreInversionesAliadosUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await updatePerfilesPreInversionesAliadosProduccion(
            usuario, data, emit));
  }

  Future<void> savePerfilesPreInversionesBeneficiarios(
      UsuarioEntity usuario,
      List<PerfilPreInversionBeneficiarioEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionBeneficiario
        .savePerfilesPreInversionesBeneficiariosUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await updatePerfilesPreInversionesBeneficiariosProduccion(
                usuario, data, emit));
  }

  Future<void> saveAlianzasBeneficiarios(
      UsuarioEntity usuario,
      List<AlianzaBeneficiarioEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await alianzaBeneficiario.saveAlianzasBeneficiariosUsecase(
        usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await updateAlianzasBeneficiariosProduccion(usuario, data, emit));
  }

  Future<void> savePerfilesPreInversionesCofinanciadores(
      UsuarioEntity usuario,
      List<PerfilPreInversionCofinanciadorEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionCofinanciador
        .savePerfilesPreInversionesCofinanciadoresUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await updatePerfilesPreInversionesCofinanciadoresProduccion(
                usuario, data, emit));
  }

  Future<void> savePerfilesPreInversionesCofinanciadoresActividadesFinancieras(
      UsuarioEntity usuario,
      List<PerfilPreInversionCofinanciadorActividadFinancieraEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorActividadFinanciera
        .savePerfilesPreInversionesCofinanciadoresActividadesFinancierasUsecase(
            usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await updatePerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccion(
                usuario, data, emit));
  }

  Future<void> savePerfilesPreInversionesCofinanciadoresDesembolsos(
      UsuarioEntity usuario,
      List<PerfilPreInversionCofinanciadorDesembolsoEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorDesembolso
        .savePerfilesPreInversionesCofinanciadoresDesembolsosUsecase(
            usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await updatePerfilesPreInversionesCofinanciadoresDesembolsosProduccion(
                usuario, data, emit));
  }

  Future<void> savePerfilesPreInversionesConsultores(
      UsuarioEntity usuario,
      List<PerfilPreInversionCofinanciadorRubroEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorRubro
        .savePerfilesPreInversionesCofinanciadoresRubrosUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await updatePerfilesPreInversionesCofinanciadoresRubrosProduccion(
                usuario, data, emit));
  }

  Future<void> savePerfilesPreInversionesConsultores(
      UsuarioEntity usuario,
      List<PerfilPreInversionConsultorEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionConsultor
        .savePerfilesPreInversionesConsultoresUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await updatePerfilesPreInversionesConsultoresProduccion(
            usuario, data, emit));
  }

  Future<void> savePerfilesPreInversionesPrecios(
      UsuarioEntity usuario,
      List<PerfilPreInversionPrecioEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionPrecio
        .savePerfilesPreInversionesPreciosUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await updatePerfilesPreInversionesPreciosProduccion(
            usuario, data, emit));
  }

  Future<void> savePerfilesPreInversionesplanesNegocios(
      UsuarioEntity usuario,
      List<PerfilPreInversionPlanNegocioEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionPlanNegocio
        .savePerfilesPreInversionesplanesNegociosUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await updatePerfilesPreInversionesplanesNegociosProduccion(
                usuario, data, emit));
  }

  Future<void> updateAliadosProduccion(UsuarioEntity usuario,
      List<AliadoEntity> data, Emitter<UploadSyncState> emit) async {
    final result = await aliadoDB.updateAliadosProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> updateBeneficiariosProduccion(UsuarioEntity usuario,
      List<BeneficiarioEntity> data, Emitter<UploadSyncState> emit) async {
    final result =
        await beneficiarioDB.updateBeneficiariosProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
  }
 */
  /* Future<void> getRemoteEvaluacionesNuevas(
      UsuarioEntity usuario, List<String> perfilesIds) async {
    final result =
        await evaluacion.getEvaluacionesNuevasUsecase(usuario, perfilesIds);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await getRemoteEvaluacionesRespuestasNuevas(usuario, data));
  }

  Future<void> getRemoteEvaluacionesRespuestasNuevas(
      UsuarioEntity usuario, List<EvaluacionEntity> evaluaciones) async {
    await evaluacionDB.saveEvaluacionesUsecaseDB(evaluaciones);
    final result = await evaluacionRespuesta
        .getEvaluacionesRespuestasNuevasUsecase(usuario, evaluaciones);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => {
              await evaluacionRespuestaDB
                  .saveEvaluacionesRespuestasUsecaseDB(data),
            });
  }

  Future<void> updateEvaluacionesRespuestasProduccion(
      UsuarioEntity usuario,
      List<EvaluacionRespuestaEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await evaluacionRespuestaDB
        .updateEvaluacionesRespuestasProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
  } */

  /*  Future<void> updateExperienciasAgricolasProduccion(
      UsuarioEntity usuario,
      List<ExperienciaAgricolaEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await experienciaAgricolaDB
        .updateExperienciasAgricolasProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> updateExperienciasPecuariasProduccion(
      UsuarioEntity usuario,
      List<ExperienciaPecuariaEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await experienciaPecuariaDB
        .updateExperienciasPecuariasProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> updatePerfilesBeneficiariosProduccion(
      UsuarioEntity usuario,
      List<PerfilBeneficiarioEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await perfilBeneficiarioDB
        .updatePerfilesBeneficiariosProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> updatePerfilesPreInversionesAliadosProduccion(
      UsuarioEntity usuario,
      List<PerfilPreInversionAliadoEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionAliadoDB
        .updatePerfilesPreInversionesAliadosProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> updatePerfilesPreInversionesBeneficiariosProduccion(
      UsuarioEntity usuario,
      List<PerfilPreInversionBeneficiarioEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionBeneficiarioDB
        .updatePerfilesPreInversionesBeneficiariosProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> updateAlianzasBeneficiariosProduccion(
      UsuarioEntity usuario,
      List<AlianzaBeneficiarioEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await alianzaBeneficiarioDB
        .updateAlianzasBeneficiariosProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> updatePerfilesPreInversionesCofinanciadoresProduccion(
      UsuarioEntity usuario,
      List<PerfilPreInversionCofinanciadorEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorDB
        .updatePerfilesPreInversionesCofinanciadoresProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
  }

  Future<void>
      updatePerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccion(
          UsuarioEntity usuario,
          List<PerfilPreInversionCofinanciadorActividadFinancieraEntity> data,
          Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorActividadFinancieraDB
        .updatePerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccionUsecaseDB(
            data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> updatePerfilesPreInversionesCofinanciadoresDesembolsosProduccion(
      UsuarioEntity usuario,
      List<PerfilPreInversionCofinanciadorDesembolsoEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorDesembolsoDB
        .updatePerfilesPreInversionesCofinanciadoresDesembolsosProduccionUsecaseDB(
            data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> updatePerfilesPreInversionesCofinanciadoresRubrosProduccion(
      UsuarioEntity usuario,
      List<PerfilPreInversionCofinanciadorRubroEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorRubroDB
        .updatePerfilesPreInversionesCofinanciadoresRubrosProduccionUsecaseDB(
            data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> updatePerfilesPreInversionesConsultoresProduccion(
      UsuarioEntity usuario,
      List<PerfilPreInversionConsultorEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionConsultorDB
        .updatePerfilesPreInversionesConsultoresProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> updatePerfilesPreInversionesPreciosProduccion(
      UsuarioEntity usuario,
      List<PerfilPreInversionPrecioEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionPrecioDB
        .updatePerfilesPreInversionesPreciosProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> updatePerfilesPreInversionesplanesNegociosProduccion(
      UsuarioEntity usuario,
      List<PerfilPreInversionPlanNegocioEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionPlanNegocioDB
        .updatePerfilesPreInversionesplanesNegociosProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
  }
 */
  // Sync Aliado
/*   Future<void> uploadAliado(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await aliadoDB.getAliadosProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveAliados(usuario, data, emit));
  } */

  // Sync Beneficiario
/*   Future<void> uploadBeneficiario(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await beneficiarioDB.getBeneficiariosProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveBeneficiarios(usuario, data, emit));
  } */

  // Sync Evaluacion Respuesta
  /*  Future<void> uploadEvaluacionRespuesta(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await evaluacionRespuestaDB
        .getEvaluacionesRespuestasProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveEvaluacionesRespuestas(usuario, data, emit));
  } */

  // Sync Experiencia Agricola
  /*  Future<void> uploadExperienciaAgricola(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await experienciaAgricolaDB
        .getExperienciasAgricolasProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveExperienciasAgricolas(usuario, data, emit));
  } */

  // Sync Experiencia Pecuaria
  /*  Future<void> uploadExperienciaPecuaria(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await experienciaPecuariaDB
        .getExperienciasPecuariasProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveExperienciasPecuarias(usuario, data, emit));
  } */

  // Sync Perfil Beneficiario
  /* Future<void> uploadPerfilBeneficiario(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await perfilBeneficiarioDB
        .getPerfilesBeneficiariosProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await savePerfilesBeneficiarios(usuario, data, emit));
  } */

  // Sync Perfil PreInversion Aliado
/*   Future<void> uploadPerfilPreInversionAliado(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionAliadoDB
        .getPerfilesPreInversionesAliadosProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await savePerfilesPreInversionesAliados(usuario, data, emit));
  } */

  // Sync Perfil PreInversion Beneficiario
  /* Future<void> uploadPerfilPreInversionBeneficiario(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionBeneficiarioDB
        .getPerfilesPreInversionesBeneficiariosProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await savePerfilesPreInversionesBeneficiarios(usuario, data, emit));
  } */

  // Sync Alianza Beneficiario
  /*  Future<void> uploadAlianzaBeneficiario(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await alianzaBeneficiarioDB
        .getAlianzasBeneficiariosProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveAlianzasBeneficiarios(usuario, data, emit));
  } */

  // Sync Perfil PreInversion Cofinanciador
/*   Future<void> uploadPerfilPreInversionCofinanciador(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorDB
        .getPerfilesPreInversionesCofinanciadoresProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await savePerfilesPreInversionesCofinanciadores(
            usuario, data, emit));
  } */

  // Sync Perfil PreInversion Cofinanciador Actividad Financiera
/*   Future<void> uploadPerfilPreInversionCofinanciadorActividadFinanciera(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorActividadFinancieraDB
        .getPerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await savePerfilesPreInversionesCofinanciadoresActividadesFinancieras(
                usuario, data, emit));
  } */

  // Sync Perfil PreInversion Cofinanciador Desembolso
/*   Future<void> uploadPerfilPreInversionCofinanciadorDesembolso(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorDesembolsoDB
        .getPerfilesPreInversionesCofinanciadoresDesembolsosProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await savePerfilesPreInversionesCofinanciadoresDesembolsos(
                usuario, data, emit));
  } */

  // Sync Perfil PreInversion Cofinanciador Rubro
/*   Future<void> uploadPerfilPreInversionCofinanciadorRubro(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorRubroDB
        .getPerfilesPreInversionesCofinanciadoresRubrosProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await savePerfilesPreInversionesCofinanciadoresRubros(
            usuario, data, emit));
  } */

  // Sync Perfil PreInversion Consultro
  /* Future<void> uploadPerfilPreInversionConsultor(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionConsultorDB
        .getPerfilesPreInversionesConsultoresProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await savePerfilesPreInversionesConsultores(usuario, data, emit));
  } */

  // Sync Perfil PreInversion Cofinanciador Rubro
  /* Future<void> uploadPerfilPreInversionPrecio(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionPrecioDB
        .getPerfilesPreInversionesPreciosProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await savePerfilesPreInversionesPrecios(usuario, data, emit));
  } */

  // Sync Perfil PreInversion Cofinanciador Rubro
  /* Future<void> uploadPerfilPreInversionPlanNegocio(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionPlanNegocioDB
        .getPerfilesPreInversionesplanesNegociosProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await savePerfilesPreInversionesplanesNegocios(
            usuario, data, emit));
  } */
}
