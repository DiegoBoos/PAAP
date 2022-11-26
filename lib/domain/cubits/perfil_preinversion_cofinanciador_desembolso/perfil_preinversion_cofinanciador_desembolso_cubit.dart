import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_cofinanciador_desembolso_entity.dart';
import '../../usecases/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_db_usecase.dart';

part 'perfil_preinversion_cofinanciador_desembolso_state.dart';

class PerfilPreInversionCofinanciadorDesembolsoCubit
    extends Cubit<PerfilPreInversionCofinanciadorDesembolsoState> {
  final PerfilPreInversionCofinanciadorDesembolsoUsecaseDB
      perfilPreInversionCofinanciadorDesembolsoDB;

  PerfilPreInversionCofinanciadorDesembolsoCubit(
      {required this.perfilPreInversionCofinanciadorDesembolsoDB})
      : super(PerfilPreInversionCofinanciadorDesembolsoInitial());

  void initState() => emit(PerfilPreInversionCofinanciadorDesembolsoInitial());

  void savePerfilPreInversionCofinanciadorDesembolsoDB(
      PerfilPreInversionCofinanciadorDesembolsoEntity
          perfilPreInversionCofinanciadorDesembolsoEntity) async {
    final result = await perfilPreInversionCofinanciadorDesembolsoDB
        .savePerfilPreInversionCofinanciadorDesembolsoUsecaseDB(
            perfilPreInversionCofinanciadorDesembolsoEntity);
    result.fold(
        (failure) => emit(PerfilPreInversionCofinanciadorDesembolsoError(
            failure.properties.first)),
        (data) => emit(PerfilPreInversionCofinanciadorDesembolsoSaved()));
  }

  void selectPerfilPreInversionCofinanciadorDesembolso(
      String perfilPreInversionId,
      String cofinanciadorId,
      String desembolsoId) async {
    final result = await perfilPreInversionCofinanciadorDesembolsoDB
        .getPerfilPreInversionCofinanciadorDesembolsoUsecaseDB(
            perfilPreInversionId, cofinanciadorId, desembolsoId);
    result.fold(
        (failure) => emit(PerfilPreInversionCofinanciadorDesembolsoError(
            failure.properties.first)), (data) {
      if (data == null) {
        emit(PerfilPreInversionCofinanciadorDesembolsoError(
            'No se pudo cargar la información del desembolso del confinanciador de preinversion'));
      } else {
        emit(PerfilPreInversionCofinanciadorDesembolsoLoaded(data));
      }
    });
  }

  void changePerfilPreInversion(String value) {
    final perfilPreInversionId = state.perfilPreInversionCofinanciadorDesembolso
        .copyWith(perfilPreInversionId: value);
    emit(
        PerfilPreInversionCofinanciadorDesembolsoChanged(perfilPreInversionId));
  }

  void changePerfilPreInversionCofinanciador(String value) {
    final cofinanciadorId = state.perfilPreInversionCofinanciadorDesembolso
        .copyWith(cofinanciadorId: value);
    emit(PerfilPreInversionCofinanciadorDesembolsoChanged(cofinanciadorId));
  }

  void changeDesembolso(String? value) {
    final desembolsoChanged = state.perfilPreInversionCofinanciadorDesembolso
        .copyWith(desembolsoId: value);
    emit(PerfilPreInversionCofinanciadorDesembolsoChanged(desembolsoChanged));
  }

  void changeFecha(String text) {
    final fechaChanged =
        state.perfilPreInversionCofinanciadorDesembolso.copyWith(fecha: text);
    emit(PerfilPreInversionCofinanciadorDesembolsoChanged(fechaChanged));
  }

  void canCreateActividadFinanciera() {
    final canCreateActividadFinanciera = state
        .perfilPreInversionCofinanciadorDesembolso
        .copyWith(canCreateActividadFinanciera: true);
    emit(PerfilPreInversionCofinanciadorDesembolsoChanged(
        canCreateActividadFinanciera));
  }
}
