import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_cofinanciador_desembolso_entity.dart';
import '../../usecases/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_db_usecase.dart';

part 'perfil_preinversion_cofinanciador_desembolso_state.dart';

class PerfilPreInversionCofinanciadorDesembolsoCubit
    extends Cubit<PerfilPreInversionCofinanciadorDesembolsotate> {
  final PerfilPreInversionCofinanciadorDesembolsoUsecaseDB
      perfilPreInversionCofinanciadorDesembolsoDB;

  PerfilPreInversionCofinanciadorDesembolsoCubit(
      {required this.perfilPreInversionCofinanciadorDesembolsoDB})
      : super(PerfilPreInversionCofinanciadorDesembolsoInitial());

  void initState() => emit(PerfilPreInversionCofinanciadorDesembolsoInitial());

  void selectPerfilPreInversionCofinanciadorDesembolso(
      String cofinanciadorId) async {
    final result = await perfilPreInversionCofinanciadorDesembolsoDB
        .getPerfilPreInversionCofinanciadorDesembolsoUsecaseDB(cofinanciadorId);
    result.fold(
        (failure) => emit(PerfilPreInversionCofinanciadorDesembolsoError(
            failure.properties.first)),
        (data) => emit(PerfilPreInversionCofinanciadorDesembolsoLoaded(data)));
  }

  void changeDesembolso(String? value) {
    final desembolsoChanged = state.perfilPreInversionCofinanciadorDesembolso
        ?.copyWith(desembolsoId: value);
    emit(PerfilPreInversionCofinanciadorDesembolsoLoaded(desembolsoChanged));
  }

  void changeFecha(String text) {
    final fechaChanged =
        state.perfilPreInversionCofinanciadorDesembolso?.copyWith(fecha: text);
    emit(PerfilPreInversionCofinanciadorDesembolsoLoaded(fechaChanged));
  }
}
