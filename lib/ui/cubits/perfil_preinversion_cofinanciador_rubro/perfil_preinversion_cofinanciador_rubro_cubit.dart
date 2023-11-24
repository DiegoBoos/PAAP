import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/perfil_preinversion_cofinanciador_rubro_entity.dart';
import '../../../domain/usecases/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_db_usecase.dart';

part 'perfil_preinversion_cofinanciador_rubro_state.dart';

class PerfilPreInversionCofinanciadorRubroCubit
    extends Cubit<PerfilPreInversionCofinanciadorRubroState> {
  final PerfilPreInversionCofinanciadorRubroUsecaseDB
      perfilPreInversionCofinanciadorRubroDB;

  PerfilPreInversionCofinanciadorRubroCubit(
      {required this.perfilPreInversionCofinanciadorRubroDB})
      : super(PerfilPreInversionCofinanciadorRubroInitial());

  void initState() => emit(PerfilPreInversionCofinanciadorRubroInitial());

  void getPerfilPreInversionCofinanciadorRubro(
      String perfilPreInversionId, String cofinanciadorId) async {
    final result = await perfilPreInversionCofinanciadorRubroDB
        .getPerfilPreInversionCofinanciadorRubroUsecaseDB(
            perfilPreInversionId, cofinanciadorId);
    result.fold(
        (failure) => emit(PerfilPreInversionCofinanciadorRubroError(
            failure.properties.first)), (data) {
      if (data != null) {
        emit(PerfilPreInversionCofinanciadorRubroLoaded(data));
      }
    });
  }

  void savePerfilPreInversionCofinanciadorRubroDB() async {
    final result = await perfilPreInversionCofinanciadorRubroDB
        .savePerfilPreInversionCofinanciadorRubroUsecaseDB(
            state.perfilPreInversionCofinanciadorRubro);
    result.fold((failure) {
      emit(PerfilPreInversionCofinanciadorRubroError(failure.properties.first));
    }, (data) {
      emit(PerfilPreInversionCofinanciadorRubroSaved(
          perfilPreInversionCofinanciadorRubro:
              state.perfilPreInversionCofinanciadorRubro));
    });
  }

  void changePerfilPreInversionId(String value) {
    final perfilPreInversionId = state.perfilPreInversionCofinanciadorRubro
        .copyWith(perfilPreInversionId: value);
    emit(PerfilPreInversionCofinanciadorRubroChanged(perfilPreInversionId));
  }

  void changeCofinanciadorId(String value) {
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

  void changeDesembolso(String? value) {
    final desembolsoChanged = state.perfilPreInversionCofinanciadorRubro
        .copyWith(desembolsoId: value);
    emit(PerfilPreInversionCofinanciadorRubroChanged(desembolsoChanged));
  }

  void changeActividadFinanciera(String? value) {
    final actividadFinancieraChanged = state
        .perfilPreInversionCofinanciadorRubro
        .copyWith(actividadFinancieraId: value);
    emit(PerfilPreInversionCofinanciadorRubroChanged(
        actividadFinancieraChanged));
  }
}
