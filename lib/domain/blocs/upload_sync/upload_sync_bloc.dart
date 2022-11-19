import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/usuario_entity.dart';
import '../../usecases/aliado/aliado_exports.dart';
import '../../usecases/beneficiario/beneficiario_exports.dart';
import '../../usecases/evaluacion/evaluacion_exports.dart';
import '../../usecases/evaluacion_respuesta/evaluacion_respuesta_exports.dart';
import '../../usecases/experiencia_agricola/experiencia_agricola_exports.dart';
import '../../usecases/experiencia_pecuaria/experiencia_pecuaria_exports.dart';
import '../../usecases/perfil_beneficiario/perfil_beneficiario_exports.dart';
import '../../usecases/perfil_preinversion_aliado/perfil_preinversion_aliado_exports.dart';
import '../../usecases/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_exports.dart';
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
  final EvaluacionRespuestaUsecase evaluacionRespuesta;
  final EvaluacionRespuestaUsecaseDB evaluacionRespuestaDB;
  final AliadoUsecase aliado;
  final AliadoUsecaseDB aliadoDB;
  final PerfilPreInversionAliadoUsecase perfilPreInversionAliado;
  final PerfilPreInversionAliadoUsecaseDB perfilPreInversionAliadoDB;

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
    required this.aliado,
    required this.aliadoDB,
    required this.perfilPreInversionAliado,
    required this.perfilPreInversionAliadoDB,
  }) : super(UploadSyncInitial()) {
    on<UploadStarted>((event, emit) async {
      final usuario = event.usuario;

      add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
          title: 'Sincronizando Visitas',
          counter: state.uploadProgressModel!.counter + 1,
          percent: calculatePercent())));
      await uploadVisita(usuario, emit);

      add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
          title: 'Sincronizando Evaluaciones',
          counter: state.uploadProgressModel!.counter + 1,
          percent: calculatePercent())));
      await uploadEvaluacion(usuario, emit);

      add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
          title: 'Sincronizando Evaluaciones Respuestas',
          counter: state.uploadProgressModel!.counter + 1,
          percent: calculatePercent())));
      await uploadEvaluacionRespuesta(usuario, emit);

      add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
          title: 'Sincronizando Beneficiarios',
          counter: state.uploadProgressModel!.counter + 1,
          percent: calculatePercent())));
      await uploadBeneficiario(usuario, emit);

      add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
          title: 'Sincronizando Experiencias Agrícolas',
          counter: state.uploadProgressModel!.counter + 1,
          percent: calculatePercent())));
      await uploadExperienciaAgricola(usuario, emit);

      add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
          title: 'Sincronizando Experiencias Pecuarias',
          counter: state.uploadProgressModel!.counter + 1,
          percent: calculatePercent())));
      await uploadExperienciaPecuaria(usuario, emit);

      add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
          title: 'Sincronizando Perfil Beneficiarios',
          counter: state.uploadProgressModel!.counter + 1,
          percent: calculatePercent())));
      await uploadPerfilBeneficiario(usuario, emit);

      add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
          title: 'Sincronizando Experiencias Agrícolas',
          counter: state.uploadProgressModel!.counter + 1,
          percent: calculatePercent())));
      await uploadPerfilPreInversionBeneficiario(usuario, emit);

      add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
          title: 'Sincronizando Aliados',
          counter: state.uploadProgressModel!.counter + 1,
          percent: calculatePercent())));
      await uploadAliado(usuario, emit);

      add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
          title: 'Sincronizando Perfil Preinversion Aliados',
          counter: state.uploadProgressModel!.counter + 1,
          percent: calculatePercent())));
      await uploadPerfilPreInversionAliado(usuario, emit);

      add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
          title: 'Sincronización Completada',
          counter: state.uploadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });

    on<UploadStatusChanged>((event, emit) {
      event.progress.counter == 11
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

  Future<void> saveAliados(UsuarioEntity usuario, List<AliadoEntity> data,
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
  }

  Future<void> saveEvaluaciones(UsuarioEntity usuario,
      List<EvaluacionEntity> data, Emitter<UploadSyncState> emit) async {
    final result = await evaluacion.saveEvaluacionesUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await updateEvaluacionesProduccion(usuario, data, emit));
  }

  Future<void> saveEvaluacionesRespuestas(
      UsuarioEntity usuario,
      List<EvaluacionRespuestaEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await evaluacionRespuesta.saveEvaluacionesRespuestasUsecase(
        usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await updateEvaluacionesRespuestasProduccion(usuario, data, emit));
  }

  Future<void> saveExperienciasAgricolas(
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

  Future<void> saveVisitas(UsuarioEntity usuario, List<VisitaEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await visita.saveVisitasUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await updateVisitasProduccion(usuario, data, emit));
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

  Future<void> updateEvaluacionesProduccion(UsuarioEntity usuario,
      List<EvaluacionEntity> data, Emitter<UploadSyncState> emit) async {
    final result =
        await evaluacionDB.updateEvaluacionesProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> updateEvaluacionesRespuestasProduccion(
      UsuarioEntity usuario,
      List<EvaluacionRespuestaEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await evaluacionRespuestaDB
        .updateEvaluacionesRespuestasProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
  }

  Future<void> updateExperienciasAgricolasProduccion(
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

  Future<void> updateVisitasProduccion(UsuarioEntity usuario,
      List<VisitaEntity> data, Emitter<UploadSyncState> emit) async {
    final result = await visitaDB.updateVisitasProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
  }

  // Sync Aliado
  Future<void> uploadAliado(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await aliadoDB.getAliadosProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveAliados(usuario, data, emit));
  }

  // Sync Beneficiario
  Future<void> uploadBeneficiario(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await beneficiarioDB.getBeneficiariosProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveBeneficiarios(usuario, data, emit));
  }

  // Sync Evaluacion
  Future<void> uploadEvaluacion(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await evaluacionDB.getEvaluacionesProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveEvaluaciones(usuario, data, emit));
  }

  // Sync Evaluacion Respuesta
  Future<void> uploadEvaluacionRespuesta(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await evaluacionRespuestaDB
        .getEvaluacionesRespuestasProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveEvaluacionesRespuestas(usuario, data, emit));
  }

  // Sync Experiencia Agricola
  Future<void> uploadExperienciaAgricola(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await experienciaAgricolaDB
        .getExperienciasAgricolasProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveExperienciasAgricolas(usuario, data, emit));
  }

  // Sync Experiencia Pecuaria
  Future<void> uploadExperienciaPecuaria(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await experienciaPecuariaDB
        .getExperienciasPecuariasProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveExperienciasPecuarias(usuario, data, emit));
  }

  // Sync Perfil Beneficiario
  Future<void> uploadPerfilBeneficiario(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await perfilBeneficiarioDB
        .getPerfilesBeneficiariosProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await savePerfilesBeneficiarios(usuario, data, emit));
  }

  // Sync Perfil PreInversion Aliado
  Future<void> uploadPerfilPreInversionAliado(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionAliadoDB
        .getPerfilesPreInversionesAliadosProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await savePerfilesPreInversionesAliados(usuario, data, emit));
  }

  // Sync Perfil PreInversion Beneficiario
  Future<void> uploadPerfilPreInversionBeneficiario(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionBeneficiarioDB
        .getPerfilesPreInversionesBeneficiariosProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await savePerfilesPreInversionesBeneficiarios(usuario, data, emit));
  }

  // Sync Visita
  Future<void> uploadVisita(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await visitaDB.getVisitasProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveVisitas(usuario, data, emit));
  }
}
