import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/perfil_preinversion_cofinanciador_desembolso_entity.dart';
import '../../../domain/usecases/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_db_usecase.dart';

part 'perfil_preinversion_cofinanciador_desembolso_state.dart';

class PerfilPreInversionCofinanciadorDesembolsoCubit
    extends Cubit<PerfilPreInversionCofinanciadorDesembolsoState> {
  final PerfilPreInversionCofinanciadorDesembolsoUsecaseDB
      perfilPreInversionCofinanciadorDesembolsoDB;

  PerfilPreInversionCofinanciadorDesembolsoCubit(
      {required this.perfilPreInversionCofinanciadorDesembolsoDB})
      : super(PerfilPreInversionCofinanciadorDesembolsoInitial());

  void initState() => emit(PerfilPreInversionCofinanciadorDesembolsoInitial());

  void getPerfilPreInversionCofinanciadorDesembolso(
      String perfilPreInversionId, String cofinanciadorId) async {
    final result = await perfilPreInversionCofinanciadorDesembolsoDB
        .getPerfilPreInversionCofinanciadorDesembolsoUsecaseDB(
            perfilPreInversionId, cofinanciadorId);
    result.fold((failure) {
      emit(PerfilPreInversionCofinanciadorDesembolsoError(
          failure.properties.first));
    }, (data) {
      if (data != null) {
        emit(PerfilPreInversionCofinanciadorDesembolsoLoaded(data));
      }
    });
  }

  void savePerfilPreInversionCofinanciadorDesembolsoDB() async {
    final result = await perfilPreInversionCofinanciadorDesembolsoDB
        .savePerfilPreInversionCofinanciadorDesembolsoUsecaseDB(
            state.perfilPreInversionCofinanciadorDesembolso);
    result.fold((failure) {
      emit(PerfilPreInversionCofinanciadorDesembolsoError(
          failure.properties.first));
    }, (data) {
      emit(PerfilPreInversionCofinanciadorDesembolsoSaved(
          perfilPreInversionCofinanciadorDesembolso:
              state.perfilPreInversionCofinanciadorDesembolso));
    });
  }

  void changePerfilPreInversionId(String value) {
    final perfilPreInversionId = state.perfilPreInversionCofinanciadorDesembolso
        .copyWith(perfilPreInversionId: value);
    emit(
        PerfilPreInversionCofinanciadorDesembolsoChanged(perfilPreInversionId));
  }

  void changeCofinanciador(String value) {
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
}
