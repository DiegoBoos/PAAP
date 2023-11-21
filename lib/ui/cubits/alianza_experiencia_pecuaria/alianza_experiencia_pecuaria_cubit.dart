import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/alianza_experiencia_pecuaria_entity.dart';
import '../../../domain/usecases/alianza_experiencia_pecuaria/alianza_experiencia_pecuaria_db_usecase.dart';

part '../alianza_experiencia_pecuaria/alianza_experiencia_pecuaria_state.dart';

class AlianzaExperienciaPecuariaCubit
    extends Cubit<AlianzaExperienciaPecuariaState> {
  final AlianzaExperienciaPecuariaUsecaseDB alianzaExperienciaPecuariaDB;

  AlianzaExperienciaPecuariaCubit({required this.alianzaExperienciaPecuariaDB})
      : super(AlianzaExperienciaPecuariaInitial());

  void initState() => emit(AlianzaExperienciaPecuariaInitial());

  void selectAlianzaExperienciaPecuaria(
      String tipoActividadProductivaId, String beneficiarioId) async {
    final result = await alianzaExperienciaPecuariaDB
        .getAlianzaExperienciaPecuariaUsecaseDB(
            tipoActividadProductivaId, beneficiarioId);
    result.fold(
        (failure) =>
            emit(AlianzaExperienciaPecuariaError(failure.properties.first)),
        (data) {
      if (data != null) {
        emit(AlianzaExperienciaPecuariaLoaded(data));
      } else {
        emit(AlianzaExperienciaPecuariaInitial());
      }
    });
  }

  void saveAlianzaExperienciaPecuariaDB(
      AlianzaExperienciaPecuariaEntity alianzaExperienciaPecuariaEntity) async {
    final result = await alianzaExperienciaPecuariaDB
        .saveAlianzaExperienciaPecuariaUsecaseDB(
            alianzaExperienciaPecuariaEntity);
    result.fold(
        (failure) =>
            emit(AlianzaExperienciaPecuariaError(failure.properties.first)),
        (data) => emit(AlianzaExperienciaPecuariaSaved(
            alianzaExperienciaPecuaria: alianzaExperienciaPecuariaEntity)));
  }

  void changeTipoActividadProductiva(String? value) {
    final tipoActividadProductivaChanged = state.alianzaExperienciaPecuaria
        .copyWith(tipoActividadProductivaId: value);
    emit(AlianzaExperienciaPecuariaChanged(tipoActividadProductivaChanged));
  }

  void changeFrecuencia(String? newValue) {
    final frecuenciaChanged =
        state.alianzaExperienciaPecuaria.copyWith(frecuenciaId: newValue);
    emit(AlianzaExperienciaPecuariaChanged(frecuenciaChanged));
  }

  void changeCantidadAnimales(String? newValue) {
    final cantidadAnimalesChanged =
        state.alianzaExperienciaPecuaria.copyWith(cantidadAnimales: newValue);
    emit(AlianzaExperienciaPecuariaChanged(cantidadAnimalesChanged));
  }

  void changeCantidadCria(String? newValue) {
    final cantidadCriaChanged =
        state.alianzaExperienciaPecuaria.copyWith(cantidadCria: newValue);
    emit(AlianzaExperienciaPecuariaChanged(cantidadCriaChanged));
  }

  void changeCantidadLevante(String? newValue) {
    final cantidadLevanteChanged =
        state.alianzaExperienciaPecuaria.copyWith(cantidadLevante: newValue);
    emit(AlianzaExperienciaPecuariaChanged(cantidadLevanteChanged));
  }

  void changeCantidadCeba(String? newValue) {
    final cantidadCebaChanged =
        state.alianzaExperienciaPecuaria.copyWith(cantidadCeba: newValue);
    emit(AlianzaExperienciaPecuariaChanged(cantidadCebaChanged));
  }

  void changeCantidadLeche(String? newValue) {
    final cantidadLecheChanged =
        state.alianzaExperienciaPecuaria.copyWith(cantidadLeche: newValue);
    emit(AlianzaExperienciaPecuariaChanged(cantidadLecheChanged));
  }

  void changeValorJornal(String? newValue) {
    final valorJornalChanged =
        state.alianzaExperienciaPecuaria.copyWith(valorJornal: newValue);
    emit(AlianzaExperienciaPecuariaChanged(valorJornalChanged));
  }

  void changeCostosInsumos(String? newValue) {
    final costosInsumosChanged =
        state.alianzaExperienciaPecuaria.copyWith(costosInsumos: newValue);
    emit(AlianzaExperienciaPecuariaChanged(costosInsumosChanged));
  }

  void changeIngresos(String? newValue) {
    final ingresosChanged =
        state.alianzaExperienciaPecuaria.copyWith(ingresos: newValue);
    emit(AlianzaExperienciaPecuariaChanged(ingresosChanged));
  }

  void changeBeneficiarioId(String value) {
    final beneficiarioIdChanged =
        state.alianzaExperienciaPecuaria.copyWith(beneficiarioId: value);
    emit(AlianzaExperienciaPecuariaChanged(beneficiarioIdChanged));
  }
}
