import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_entity.dart';
import '../../usecases/perfil_preinversion/perfil_preinversion_db_usecase.dart';
part '../perfil_preinversion/perfil_preinversion_state.dart';

class PerfilPreInversionCubit extends Cubit<PerfilPreInversionState> {
  final PerfilPreInversionUsecaseDB perfilPreInversionDB;

  PerfilPreInversionCubit({required this.perfilPreInversionDB})
      : super(PerfilPreInversionInitial());

  void getPerfilPreInversionDB(String id) async {
    final result =
        await perfilPreInversionDB.getPerfilPreInversionUsecaseDB(id);
    result.fold(
        (failure) => emit(PerfilPreInversionError(failure.properties.first)),
        (data) => emit(PerfilPreInversionLoaded(data)));
  }

  void initState() => emit(PerfilPreInversionInitial());

  /* void changeFechaExpedicion(String value) {
    state.perfilPreInversion!.copyWith(fechaExpedicionDocumento: value);
  }

  void changeFechaNacimiento(String value) {
    state.perfilPreInversion!.copyWith(fechaNacimiento: value);
  }

  void changePrimerNombre(String value) {
    state.perfilPreInversion!.copyWith(nombre1: value);
  }

  void changeSegundoNombre(String value) {
    state.perfilPreInversion!.copyWith(nombre2: value);
  }

  void changePrimerApellido(String value) {
    state.perfilPreInversion!.copyWith(apellido1: value);
  }

  void changeSegundoApellido(String value) {
    state.perfilPreInversion!.copyWith(apellido2: value);
  }

  void changeGenero(String value) {
    state.perfilPreInversion!.copyWith(generoId: value);
  }

  void changeEstadoCivil(String value) {
    state.perfilPreInversion!.copyWith(: value);
  }

  void changeGrupoEspecial(String value) {
    state.perfilPreInversion!.copyWith(grupoEspecialId: value);
  }

  void changeDiscapacidad(String value) {
    state.perfilPreInversion!.copyWith(: value);
  }

  void changeTelefonoMovil(String value) {
    state.perfilPreInversion!.copyWith(telefonoMovil: value);
  }

  void changeDocumento(String s) {} */
}
