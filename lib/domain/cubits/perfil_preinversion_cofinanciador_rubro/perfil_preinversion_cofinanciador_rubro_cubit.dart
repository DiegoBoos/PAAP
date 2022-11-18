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

  void selectPerfilPreInversionCofinanciadorRubro(
      String cofinanciadorId) async {
    final result = await perfilPreInversionCofinanciadorRubroDB
        .getPerfilPreInversionCofinanciadorRubroUsecaseDB(cofinanciadorId);
    result.fold(
        (failure) => emit(PerfilPreInversionCofinanciadorRubroError(
            failure.properties.first)),
        (data) => emit(PerfilPreInversionCofinanciadorRubroLoaded(data)));
  }

  void changeRubro(String? value) {
    final rubroChanged =
        state.perfilPreInversionCofinanciadorRubro?.copyWith(rubroId: value);
    emit(PerfilPreInversionCofinanciadorRubroLoaded(rubroChanged));
  }

  void changeValor(String? newValue) {
    final valorChanged =
        state.perfilPreInversionCofinanciadorRubro?.copyWith(valor: newValue);
    emit(PerfilPreInversionCofinanciadorRubroLoaded(valorChanged));
  }

  void changeActividadFinanciera(String? value) {
    final actividadFinancieraChanged = state
        .perfilPreInversionCofinanciadorRubro
        ?.copyWith(actividadFinancieraId: value);
    emit(
        PerfilPreInversionCofinanciadorRubroLoaded(actividadFinancieraChanged));
  }
}
