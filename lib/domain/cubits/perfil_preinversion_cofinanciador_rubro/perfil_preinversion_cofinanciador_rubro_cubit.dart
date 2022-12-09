import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_cofinanciador_rubro_entity.dart';
import '../../usecases/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_db_usecase.dart';

part 'perfil_preinversion_cofinanciador_rubro_state.dart';

class PerfilPreInversionCofinanciadorRubroCubit
    extends Cubit<PerfilPreInversionCofinanciadorRubroState> {
  final PerfilPreInversionCofinanciadorRubroUsecaseDB
      perfilPreInversionCofinanciadorRubroDB;

  PerfilPreInversionCofinanciadorRubroCubit(
      {required this.perfilPreInversionCofinanciadorRubroDB})
      : super(PerfilPreInversionCofinanciadorRubroInitial());

  void initState() => emit(PerfilPreInversionCofinanciadorRubroInitial());

  Future<PerfilPreInversionCofinanciadorRubroEntity?>
      getPerfilPreInversionCofinanciadorRubro(
          String perfilPreInversionId,
          String cofinanciadorId,
          String desembolsoId,
          String actividadFinancieraId) async {
    final result = await perfilPreInversionCofinanciadorRubroDB
        .getPerfilPreInversionCofinanciadorRubroUsecaseDB(perfilPreInversionId,
            cofinanciadorId, desembolsoId, actividadFinancieraId);
    return result.fold((failure) => null, (data) {
      if (data != null) {
        emit(PerfilPreInversionCofinanciadorRubroLoaded(data));
      } else {
        emit(PerfilPreInversionCofinanciadorRubroInitial());
      }
      return data;
    });
  }

  void savePerfilPreInversionCofinanciadorRubroDB(
      PerfilPreInversionCofinanciadorRubroEntity
          perfilPreInversionCofinanciadorRubroEntity) async {
    final result = await perfilPreInversionCofinanciadorRubroDB
        .savePerfilPreInversionCofinanciadorRubroUsecaseDB(
            perfilPreInversionCofinanciadorRubroEntity);
    result.fold(
        (failure) => emit(PerfilPreInversionCofinanciadorRubroError(
            failure.properties.first)),
        (data) => emit(PerfilPreInversionCofinanciadorRubroSaved()));
  }

  void changePerfilPreInversion(String value) {
    final perfilPreInversionId = state.perfilPreInversionCofinanciadorRubro
        .copyWith(perfilPreInversionId: value);
    emit(PerfilPreInversionCofinanciadorRubroChanged(perfilPreInversionId));
  }

  void changeCofinanciador(String value) {
    final cofinanciadorId = state.perfilPreInversionCofinanciadorRubro
        .copyWith(cofinanciadorId: value);
    emit(PerfilPreInversionCofinanciadorRubroChanged(cofinanciadorId));
  }

  void changeRubro(String? value) {
    final rubroChanged =
        state.perfilPreInversionCofinanciadorRubro.copyWith(rubroId: value);
    emit(PerfilPreInversionCofinanciadorRubroChanged(rubroChanged));
  }

  void changeValor(String? newValue) {
    final valorChanged =
        state.perfilPreInversionCofinanciadorRubro.copyWith(valor: newValue);
    emit(PerfilPreInversionCofinanciadorRubroChanged(valorChanged));
  }

  void changeActividadFinanciera(String? value) {
    final actividadFinancieraChanged = state
        .perfilPreInversionCofinanciadorRubro
        .copyWith(actividadFinancieraId: value);
    emit(PerfilPreInversionCofinanciadorRubroChanged(
        actividadFinancieraChanged));
  }
}
