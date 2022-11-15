import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/usuario_entity.dart';
import '../../usecases/evaluacion/evaluacion_exports.dart';
import '../../usecases/evaluacion_respuesta/evaluacion_respuesta_exports.dart';
import '../../usecases/visita/visita_exports.dart';

part 'upload_sync_event.dart';
part 'upload_sync_state.dart';

class UploadSyncBloc extends Bloc<UploadSyncEvent, UploadSyncState> {
  final VisitaUsecase visita;
  final VisitaUsecaseDB visitaDB;
  final EvaluacionUsecase evaluacion;
  final EvaluacionUsecaseDB evaluacionDB;
  final EvaluacionRespuestaUsecase evaluacionRespuesta;
  final EvaluacionRespuestaUsecaseDB evaluacionRespuestaDB;

  UploadSyncBloc({
    required this.visita,
    required this.visitaDB,
    required this.evaluacion,
    required this.evaluacionDB,
    required this.evaluacionRespuesta,
    required this.evaluacionRespuestaDB,
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
}
