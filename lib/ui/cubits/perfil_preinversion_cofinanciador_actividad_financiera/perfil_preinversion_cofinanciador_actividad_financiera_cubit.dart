import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/perfil_preinversion_cofinanciador_actividad_financiera_entity.dart';
import '../../../domain/usecases/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_db_usecase.dart';

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

  void getPerfilPreInversionCofinanciadorActividadFinanciera(
    String perfilPreInversionId,
    String cofinanciadorId,
  ) async {
    final result = await perfilPreInversionCofinanciadorActividadFinancieraDB
        .getPerfilPreInversionCofinanciadorActividadFinancieraUsecaseDB(
            perfilPreInversionId, cofinanciadorId);
    result.fold(
        (failure) => emit(
            PerfilPreInversionCofinanciadorActividadFinancieraError(
                failure.properties.first)), (data) {
      if (data != null) {
        emit(PerfilPreInversionCofinanciadorActividadFinancieraLoaded(data));
      } else {
        emit(PerfilPreInversionCofinanciadorActividadFinancieraInitial());
      }
    });
  }

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
        (data) => emit(PerfilPreInversionCofinanciadorActividadFinancieraSaved(
            perfilPreInversionCofinanciadorActividadFinanciera:
                perfilPreInversionCofinanciadorActividadFinancieraEntity)));
  }

  void changePerfilPreInversionId(String value) {
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
}
