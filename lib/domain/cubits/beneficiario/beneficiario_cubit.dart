import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/beneficiario_entity.dart';
import '../../usecases/beneficiario/beneficiario_db_usecase.dart';

part '../beneficiario/beneficiario_state.dart';

class BeneficiarioCubit extends Cubit<BeneficiarioState> {
  final BeneficiarioUsecaseDB beneficiarioDB;

  BeneficiarioCubit({required this.beneficiarioDB})
      : super(BeneficiarioInitial());

  void getBeneficiarioDB(String id) async {
    final result = await beneficiarioDB.getBeneficiarioUsecaseDB(id);
    result.fold((failure) => emit(BeneficiarioError(failure.properties.first)),
        (data) => emit(BeneficiarioLoaded(data)));
  }

  void initState() => emit(BeneficiarioInitial());

  void changeTipoDocumento(String value) {
    state.beneficiario!.copyWith(tipoIdentificacionId: value);
  }

  void changeFechaExpedicion(String value) {
    state.beneficiario!.copyWith(fechaExpedicionDocumento: value);
  }

  void changeFechaNacimiento(String value) {
    state.beneficiario!.copyWith(fechaNacimiento: value);
  }

  void changePrimerNombre(String value) {
    state.beneficiario!.copyWith(nombre1: value);
  }

  void changeSegundoNombre(String value) {
    state.beneficiario!.copyWith(nombre2: value);
  }

  void changePrimerApellido(String value) {
    state.beneficiario!.copyWith(apellido1: value);
  }

  void changeSegundoApellido(String value) {
    state.beneficiario!.copyWith(apellido2: value);
  }

  void changeGenero(String value) {
    state.beneficiario!.copyWith(generoId: value);
  }

/*   void changeEstadoCivil(String value) {
    state.beneficiario!.copyWith(: value);
  } */

  void changeGrupoEspecial(String value) {
    state.beneficiario!.copyWith(grupoEspecialId: value);
  }

  /* void changeDiscapacidad(String value) {
    state.beneficiario!.copyWith(: value);
  } */

  void changeTelefonoMovil(String value) {
    state.beneficiario!.copyWith(telefonoMovil: value);
  }
}
