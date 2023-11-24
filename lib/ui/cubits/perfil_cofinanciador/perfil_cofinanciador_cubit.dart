import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/perfil_cofinanciador_entity.dart';
import '../../../domain/usecases/perfil_cofinanciador/perfil_cofinanciador_db_usecase.dart';

part '../perfil_cofinanciador/perfil_cofinanciador_state.dart';

class PerfilCofinanciadorCubit extends Cubit<PerfilCofinanciadorState> {
  final PerfilCofinanciadorUsecaseDB perfilCofinanciadorDB;

  PerfilCofinanciadorCubit({required this.perfilCofinanciadorDB})
      : super(PerfilCofinanciadorInitial());

  void initState() => emit(PerfilCofinanciadorInitial());

  void setPerfilCofinanciador(PerfilCofinanciadorEntity perfilCofinanciador) {
    emit(PerfilCofinanciadorChanged(perfilCofinanciador));
  }

  void loadPerfilCofinanciador(String perfilId, String cofinanciadorId) async {
    final result = await perfilCofinanciadorDB.getPerfilCofinanciadorUsecaseDB(
        perfilId, cofinanciadorId);
    result.fold(
        (failure) => emit(PerfilCofinanciadorError(failure.properties.first)),
        (data) {
      if (data == null) {
        emit(PerfilCofinanciadorError(
            'No se encontró el cofinanciador relacionado al perfil'));
      } else {
        emit(PerfilCofinanciadorLoaded(data));
      }
    });
  }

  void savePerfilCofinanciadorDB() async {
    final result = await perfilCofinanciadorDB
        .savePerfilCofinanciadorUsecaseDB(state.perfilCofinanciador);
    result.fold(
        (failure) => emit(PerfilCofinanciadorError(failure.properties.first)),
        (data) => emit(PerfilCofinanciadorSaved(state.perfilCofinanciador)));
  }

  void changePerfilId(String? newValue) {
    final perfilIdChanged =
        state.perfilCofinanciador.copyWith(perfilId: newValue);
    emit(PerfilCofinanciadorChanged(perfilIdChanged));
  }

  void changeCofinanciadorId(String? newValue) {
    final cofinanciadorIdChanged =
        state.perfilCofinanciador.copyWith(cofinanciadorId: newValue);
    emit(PerfilCofinanciadorChanged(cofinanciadorIdChanged));
  }

  void changeMonto(String? newValue) {
    final montoChanged = state.perfilCofinanciador.copyWith(monto: newValue);
    emit(PerfilCofinanciadorChanged(montoChanged));
  }

  void changeParticipacion(String? newValue) {
    final participacionChanged =
        state.perfilCofinanciador.copyWith(participacion: newValue);
    emit(PerfilCofinanciadorChanged(participacionChanged));
  }
}
