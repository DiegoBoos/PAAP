import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_cofinanciador_actividad_financiera_entity.dart';
import '../../usecases/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_db_usecase.dart';

part 'perfil_preinversion_cofinanciador_actividad_financiera_state.dart';

class PerfilPreInversionCofinanciadorActividadFinancieraCubit
    extends Cubit<PerfilPreInversionCofinanciadorActividadFinancieraState> {
  final PerfilPreInversionCofinanciadorActividadFinancieraUsecaseDB
      perfilPreInversionCofinanciadorActividadFinancieraDB;

  PerfilPreInversionCofinanciadorActividadFinancieraCubit(
      {required this.perfilPreInversionCofinanciadorActividadFinancieraDB})
      : super(PerfilPreInversionCofinanciadorActividadFinancieraInitial());

  void initState() =>
      emit(PerfilPreInversionCofinanciadorActividadFinancieraInitial());

  void savePerfilPreInversionCofinanciadorActividadFinancieraDB(
      PerfilPreInversionCofinanciadorActividadFinancieraEntity
          perfilPreInversionCofinanciadorActividadFinancieraEntity) async {
    final result = await perfilPreInversionCofinanciadorActividadFinancieraDB
        .savePerfilPreInversionCofinanciadorActividadFinancieraUsecaseDB(
            perfilPreInversionCofinanciadorActividadFinancieraEntity);
    result.fold(
        (failure) => emit(
            PerfilPreInversionCofinanciadorActividadFinancieraError(
                failure.properties.first)),
        (data) =>
            emit(PerfilPreInversionCofinanciadorActividadFinancieraSaved()));
  }

  void selectPerfilPreInversionCofinanciadorActividadFinanciera(
      String perfilPreInversionId,
      String cofinanciadorId,
      String actividadFinancieraId,
      String desembolsoId) async {
    final result = await perfilPreInversionCofinanciadorActividadFinancieraDB
        .getPerfilPreInversionCofinanciadorActividadFinancieraUsecaseDB(
            perfilPreInversionId,
            cofinanciadorId,
            actividadFinancieraId,
            desembolsoId);
    result.fold(
        (failure) => emit(
            PerfilPreInversionCofinanciadorActividadFinancieraError(
                failure.properties.first)), (data) {
      if (data == null) {
        emit(PerfilPreInversionCofinanciadorActividadFinancieraError(
            'No se pudo cargar la información de la actividad financiera del confinanciador de preinversion'));
      } else {
        emit(PerfilPreInversionCofinanciadorActividadFinancieraLoaded(data));
      }
    });
  }

  void changePerfilPreInversion(String value) {
    final perfilPreInversion = state
        .perfilPreInversionCofinanciadorActividadFinanciera
        .copyWith(perfilPreInversionId: value);
    emit(PerfilPreInversionCofinanciadorActividadFinancieraChanged(
        perfilPreInversion));
  }

  void changeCofinanciador(String value) {
    final cofinanciador = state
        .perfilPreInversionCofinanciadorActividadFinanciera
        .copyWith(cofinanciadorId: value);
    emit(PerfilPreInversionCofinanciadorActividadFinancieraChanged(
        cofinanciador));
  }

  void changeActividadFinanciera(String? value) {
    final actividadFinancieraChanged = state
        .perfilPreInversionCofinanciadorActividadFinanciera
        .copyWith(actividadFinancieraId: value);
    emit(PerfilPreInversionCofinanciadorActividadFinancieraChanged(
        actividadFinancieraChanged));
  }

  void changeValor(String? text) {
    final valorChanged = state
        .perfilPreInversionCofinanciadorActividadFinanciera
        .copyWith(valor: text);
    emit(PerfilPreInversionCofinanciadorActividadFinancieraChanged(
        valorChanged));
  }

  void changeDesembolso(String? value) {
    final desembolsoChanged = state
        .perfilPreInversionCofinanciadorActividadFinanciera
        .copyWith(desembolsoId: value);
    emit(PerfilPreInversionCofinanciadorActividadFinancieraChanged(
        desembolsoChanged));
  }

  void canCreateRubro() {
    final canCreateRubro = state
        .perfilPreInversionCofinanciadorActividadFinanciera
        .copyWith(canCreateRubro: true);
    emit(PerfilPreInversionCofinanciadorActividadFinancieraChanged(
        canCreateRubro));
  }
}
