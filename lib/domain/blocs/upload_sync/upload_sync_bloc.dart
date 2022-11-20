import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paap/domain/usecases/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_db_usecase.dart';
import 'package:paap/domain/usecases/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_usecase.dart';
import 'package:paap/domain/usecases/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_exports.dart';

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
import '../../usecases/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_exports.dart';
import '../../usecases/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_exports.dart';
import '../../usecases/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_exports.dart';
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
    required this.perfilPreInversionCofinanciador,
    required this.perfilPreInversionCofinanciadorDB,
    required this.perfilPreInversionCofinanciadorActividadFinanciera,
    required this.perfilPreInversionCofinanciadorActividadFinancieraDB,
    required this.perfilPreInversionCofinanciadorDesembolso,
    required this.perfilPreInversionCofinanciadorDesembolsoDB,
    required this.perfilPreInversionCofinanciadorRubro,
    required this.perfilPreInversionCofinanciadorRubroDB,
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
          title: 'Sincronizando Perfil Cofinanciador',
          counter: state.uploadProgressModel!.counter + 1,
          percent: calculatePercent())));
      await uploadPerfilPreInversionCofinanciador(usuario, emit);

      add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
          title: 'Sincronizando Perfil Cofinanciador Actividad Financiera',
          counter: state.uploadProgressModel!.counter + 1,
          percent: calculatePercent())));
      await uploadPerfilPreInversionCofinanciadorActividadFinanciera(
          usuario, emit);

      add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
          title: 'Sincronizando Perfil Cofinanciador Desembolso',
          counter: state.uploadProgressModel!.counter + 1,
          percent: calculatePercent())));
      await uploadPerfilPreInversionCofinanciadorDesembolso(usuario, emit);

      add(UploadStatusChanged(state.uploadProgressModel!.copyWith(
          title: 'Sincronizando Perfil Cofinanciador Rubro',
          counter: state.uploadProgressModel!.counter + 1,
          percent: calculatePercent())));
      await uploadPerfilPreInversionCofinanciadorRubro(usuario, emit);

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

  Future<void> savePerfilesPreInversionesCofinanciadoresRubros(
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

  // Sync Perfil PreInversion Cofinanciador
  Future<void> uploadPerfilPreInversionCofinanciador(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorDB
        .getPerfilesPreInversionesCofinanciadoresProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await savePerfilesPreInversionesCofinanciadores(
            usuario, data, emit));
  }

  // Sync Perfil PreInversion Cofinanciador Actividad Financiera
  Future<void> uploadPerfilPreInversionCofinanciadorActividadFinanciera(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorActividadFinancieraDB
        .getPerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await savePerfilesPreInversionesCofinanciadoresActividadesFinancieras(
                usuario, data, emit));
  }

  // Sync Perfil PreInversion Cofinanciador Desembolso
  Future<void> uploadPerfilPreInversionCofinanciadorDesembolso(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorDesembolsoDB
        .getPerfilesPreInversionesCofinanciadoresDesembolsosProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async =>
            await savePerfilesPreInversionesCofinanciadoresDesembolsos(
                usuario, data, emit));
  }

  // Sync Perfil PreInversion Cofinanciador Rubro
  Future<void> uploadPerfilPreInversionCofinanciadorRubro(
      UsuarioEntity usuario, Emitter<UploadSyncState> emit) async {
    final result = await perfilPreInversionCofinanciadorRubroDB
        .getPerfilesPreInversionesCofinanciadoresRubrosProduccionUsecaseDB();
    result.fold(
        (failure) => add(UploadSyncError(failure.properties.first)),
        (data) async => await savePerfilesPreInversionesCofinanciadoresRubros(
            usuario, data, emit));
  }
}
