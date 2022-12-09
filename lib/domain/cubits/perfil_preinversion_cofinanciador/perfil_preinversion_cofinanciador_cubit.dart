import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_cofinanciador_entity.dart';
import '../../usecases/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_db_usecase.dart';

part '../perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_state.dart';

class PerfilPreInversionCofinanciadorCubit
    extends Cubit<PerfilPreInversionCofinanciadorState> {
  final PerfilPreInversionCofinanciadorUsecaseDB
      perfilPreInversionCofinanciadorDB;

  PerfilPreInversionCofinanciadorCubit(
      {required this.perfilPreInversionCofinanciadorDB})
      : super(PerfilPreInversionCofinanciadorInitial());

  void initState() => emit(PerfilPreInversionCofinanciadorInitial());

  void selectPerfilPreInversionCofinanciador(
      PerfilPreInversionCofinanciadorEntity perfilPreInversionCofinanciador) {
    emit(
        PerfilPreInversionCofinanciadorLoaded(perfilPreInversionCofinanciador));
  }

  void savePerfilPreInversionCofinanciadorDB(
      PerfilPreInversionCofinanciadorEntity
          perfilPreInversionCofinanciadorEntity) async {
    final result = await perfilPreInversionCofinanciadorDB
        .savePerfilPreInversionCofinanciadorUsecaseDB(
            perfilPreInversionCofinanciadorEntity);
    result.fold(
        (failure) => emit(
            PerfilPreInversionCofinanciadorError(failure.properties.first)),
        (data) => emit(PerfilPreInversionCofinanciadorSaved()));
  }

  void changePerfilPreInversionId(String? value) {
    final perfilPreInversionIdChanged = state.perfilPreInversionCofinanciador
        .copyWith(perfilPreInversionId: value);
    emit(PerfilPreInversionCofinanciadorChanged(perfilPreInversionIdChanged));
  }

  void changeMonto(String? newValue) {
    final montoChanged =
        state.perfilPreInversionCofinanciador.copyWith(monto: newValue);
    emit(PerfilPreInversionCofinanciadorChanged(montoChanged));
  }

  void changeParticipacion(String? newValue) {
    final participacionChanged =
        state.perfilPreInversionCofinanciador.copyWith(participacion: newValue);
    emit(PerfilPreInversionCofinanciadorChanged(participacionChanged));
  }

  void changeCofinanciador(String? newValue) {
    final cofinanciadorIdLoaded = state.perfilPreInversionCofinanciador
        .copyWith(cofinanciadorId: newValue);
    emit(PerfilPreInversionCofinanciadorLoaded(cofinanciadorIdLoaded));
  }

  void isEditing() {
    final isEditing =
        state.perfilPreInversionCofinanciador.copyWith(isEditing: true);
    emit(PerfilPreInversionCofinanciadorLoaded(isEditing));
  }

  void canCreateDesembolso() {
    final canCreateDesembolso = state.perfilPreInversionCofinanciador
        .copyWith(canCreateDesembolso: true);
    emit(PerfilPreInversionCofinanciadorChanged(canCreateDesembolso));
  }
}
