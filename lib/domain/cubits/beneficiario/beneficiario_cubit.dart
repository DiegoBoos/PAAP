import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/beneficiario_entity.dart';
import '../../usecases/beneficiario/beneficiario_db_usecase.dart';

part '../beneficiario/beneficiario_state.dart';

class BeneficiarioCubit extends Cubit<BeneficiarioState> {
  final BeneficiarioUsecaseDB beneficiarioDB;

  BeneficiarioCubit({required this.beneficiarioDB})
      : super(BeneficiarioInitial());

  void initState() => emit(BeneficiarioInitial());

  void loadBeneficiario(String beneficiarioId) async {
    final result =
        await beneficiarioDB.getBeneficiarioUsecaseDB(beneficiarioId);
    result.fold((failure) => emit(BeneficiarioError(failure.properties.first)),
        (data) {
      if (data != null) {
        emit(BeneficiarioLoaded(data));
      }
    });
  }

  void saveBeneficiarioDB(BeneficiarioEntity beneficiarioEntity) async {
    final result =
        await beneficiarioDB.saveBeneficiarioUsecaseDB(beneficiarioEntity);
    result.fold((failure) => emit(BeneficiarioError(failure.properties.first)),
        (data) => emit(BeneficiarioSaved()));
  }

  void changeBeneficiarioId(String? newValue) {
    final beneficiarioIdChanged =
        state.beneficiario.copyWith(beneficiarioId: newValue);
    emit(BeneficiarioChanged(beneficiarioIdChanged));
  }

  void changeTipoDocumento(String value) {
    final tipoIdentificacionChanged =
        state.beneficiario.copyWith(tipoIdentificacionId: value);
    emit(BeneficiarioChanged(tipoIdentificacionChanged));
  }

  void changeFechaExpedicion(String value) {
    final fechaExpedicionDocumentoChanged =
        state.beneficiario.copyWith(fechaExpedicionDocumento: value);
    emit(BeneficiarioChanged(fechaExpedicionDocumentoChanged));
  }

  void changeFechaNacimiento(String value) {
    final fechaNacimientoChanged =
        state.beneficiario.copyWith(fechaNacimiento: value);
    emit(BeneficiarioChanged(fechaNacimientoChanged));
  }

  void changePrimerNombre(String? newValue) {
    final primerNombreChanged = state.beneficiario.copyWith(nombre1: newValue);
    emit(BeneficiarioChanged(primerNombreChanged));
  }

  void changeSegundoNombre(String? newValue) {
    final segundoNombreChanged = state.beneficiario.copyWith(nombre2: newValue);
    emit(BeneficiarioChanged(segundoNombreChanged));
  }

  void changePrimerApellido(String? newValue) {
    final primerApellidoChanged =
        state.beneficiario.copyWith(apellido1: newValue);
    emit(BeneficiarioChanged(primerApellidoChanged));
  }

  void changeSegundoApellido(String? newValue) {
    final segundoApellidoChanged =
        state.beneficiario.copyWith(apellido2: newValue);
    emit(BeneficiarioChanged(segundoApellidoChanged));
  }

  void changeGenero(String? value) {
    final generoChanged = state.beneficiario.copyWith(generoId: value);
    emit(BeneficiarioChanged(generoChanged));
  }

  void changeGrupoEspecial(String value) {
    final grupoEspecialChanged =
        state.beneficiario.copyWith(grupoEspecialId: value);
    emit(BeneficiarioChanged(grupoEspecialChanged));
  }

  void changeTelefonoMovil(String? newValue) {
    final telefonoMovilChanged =
        state.beneficiario.copyWith(telefonoMovil: newValue);
    emit(BeneficiarioChanged(telefonoMovilChanged));
  }

  void changeActivo(bool? value) {
    final activo = state.beneficiario.copyWith(activo: value.toString());
    emit(BeneficiarioChanged(activo));
  }
}
