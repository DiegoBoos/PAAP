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

      await uploadEvaluacion(usuario, emit);

      await uploadEvaluacionRespuesta(usuario, emit);

      await uploadBeneficiario(usuario, emit);
      await uploadExperienciaAgricola(usuario, emit);
      await uploadExperienciaPecuaria(usuario, emit);
      await uploadPerfilBeneficiario(usuario, emit);
      await uploadPerfilPreInversionBeneficiario(usuario, emit);
      await uploadAliado(usuario, emit);
      await uploadPerfilPreInversionAliado(usuario, emit);
    });

    on<UploadStatusChanged>((event, emit) {
      event.progress.counter == 3
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
    final result = await visitaDB.getVisitasProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveVisitas(usuario, data, emit));
  }

  Future<void> saveVisitas(UsuarioEntity usuario, List<VisitaEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await visita.saveVisitasUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await updateVisitasProduccion(usuario, data, emit));
  }

  Future<void> updateVisitasProduccion(UsuarioEntity usuario,
      List<VisitaEntity> data, Emitter<UploadSyncState> emit) async {
    final result = await visitaDB.updateVisitasProduccionUsecaseDB(data);
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (_) {
      add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
          title: 'Sincronizando Evaluaciones',
          counter: state.uploadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  // Sync Evaluacion
  Future<void> uploadEvaluacion(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await evaluacionDB.getEvaluacionesProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveEvaluaciones(usuario, data, emit));
  }

  Future<void> saveEvaluaciones(UsuarioEntity usuario,
      List<EvaluacionEntity> data, Emitter<UploadSyncState> emit) async {
    final result = await evaluacion.saveEvaluacionesUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await updateEvaluacionesProduccion(usuario, data, emit));
  }

  Future<void> updateEvaluacionesProduccion(UsuarioEntity usuario,
      List<EvaluacionEntity> data, Emitter<UploadSyncState> emit) async {
    final result =
        await evaluacionDB.updateEvaluacionesProduccionUsecaseDB(data);
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (_) {
      add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
          title: 'Sincronizando Evaluaciones Respuestas',
          counter: state.uploadProgressModel!.counter + 1,
          percent: calculatePercent())));
    });
  }

  // Sync Evaluacion Respuesta
  Future<void> uploadEvaluacionRespuesta(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await evaluacionRespuestaDB
        .getEvaluacionesRespuestasProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveEvaluacionesRespuestas(usuario, data, emit));
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

  Future<void> updateEvaluacionesRespuestasProduccion(
      UsuarioEntity usuario,
      List<EvaluacionRespuestaEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await evaluacionRespuestaDB
        .updateEvaluacionesRespuestasProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
  }

  // Sync Beneficiario
  Future<void> uploadBeneficiario(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await beneficiarioDB.getBeneficiariosProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveBeneficiarios(usuario, data, emit));
  }

  Future<void> saveBeneficiarios(UsuarioEntity usuario,
      List<BeneficiarioEntity> data, Emitter<UploadSyncState> emit) async {
    final result = await beneficiario.saveBeneficiariosUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await updateBeneficiariosProduccion(usuario, data, emit));
  }

  Future<void> updateBeneficiariosProduccion(UsuarioEntity usuario,
      List<BeneficiarioEntity> data, Emitter<UploadSyncState> emit) async {
    final result =
        await beneficiarioDB.updateBeneficiariosProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
  }

  // Sync Experiencia Agricola
  Future<void> uploadExperienciaAgricola(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await experienciaAgricolaDB
        .getExperienciasAgricolasProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveExperienciasAgricolas(usuario, data, emit));
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

  Future<void> updateExperienciasAgricolasProduccion(
      UsuarioEntity usuario,
      List<ExperienciaAgricolaEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await experienciaAgricolaDB
        .updateExperienciasAgricolasProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
  }

  // Sync Experiencia Pecuaria
  Future<void> uploadExperienciaPecuaria(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await experienciaPecuariaDB
        .getExperienciasPecuariasProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await saveExperienciasPecuarias(usuario, data, emit));
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

  Future<void> updateExperienciasPecuariasProduccion(
      UsuarioEntity usuario,
      List<ExperienciaPecuariaEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await experienciaPecuariaDB
        .updateExperienciasPecuariasProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
  }

  // Sync Perfil Beneficiario
  Future<void> uploadPerfilBeneficiario(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await perfilBeneficiarioDB
        .getPerfilesBeneficiariosProduccionUsecaseDB();
    result.fold((failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await savePerfilesBeneficiarios(usuario, data, emit));
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

  Future<void> updatePerfilesBeneficiariosProduccion(
      UsuarioEntity usuario,
      List<PerfilBeneficiarioEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await perfilBeneficiarioDB
        .updatePerfilesBeneficiariosProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
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

  Future<void> updatePerfilesPreInversionesBeneficiariosProduccion(
      UsuarioEntity usuario,
      List<PerfilPreInversionBeneficiarioEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionBeneficiarioDB
        .updatePerfilesPreInversionesBeneficiariosProduccionUsecaseDB(data);
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

  Future<void> saveAliados(UsuarioEntity usuario, List<AliadoEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await aliado.saveAliadosUsecase(usuario, data);
    return result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await updateAliadosProduccion(usuario, data, emit));
  }

  Future<void> updateAliadosProduccion(UsuarioEntity usuario,
      List<AliadoEntity> data, Emitter<UploadSyncState> emit) async {
    final result = await aliadoDB.updateAliadosProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
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

  Future<void> updatePerfilesPreInversionesAliadosProduccion(
      UsuarioEntity usuario,
      List<PerfilPreInversionAliadoEntity> data,
      Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionAliadoDB
        .updatePerfilesPreInversionesAliadosProduccionUsecaseDB(data);
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)), (_) {});
  }
}
