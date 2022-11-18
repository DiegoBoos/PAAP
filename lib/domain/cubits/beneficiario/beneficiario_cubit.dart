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

  void selectBeneficiario(String beneficiarioId) async {
    final result =
        await beneficiarioDB.getBeneficiarioUsecaseDB(beneficiarioId);
    result.fold((failure) => emit(BeneficiarioError(failure.properties.first)),
        (data) {
      if (data == null) {
        emit(const BeneficiarioError('No se encontró el beneficiario'));
      } else {
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

  void changeTipoDocumento(String value) {
    final tipoIdentificacionChanged =
        state.beneficiario?.copyWith(tipoIdentificacionId: value);
    emit(BeneficiarioLoaded(tipoIdentificacionChanged));
  }

  void changeFechaExpedicion(String value) {
    final fechaExpedicionDocumentoChanged =
        state.beneficiario?.copyWith(fechaExpedicionDocumento: value);
    emit(BeneficiarioLoaded(fechaExpedicionDocumentoChanged));
  }

  void changeFechaNacimiento(String value) {
    final fechaNacimientoChanged =
        state.beneficiario?.copyWith(fechaNacimiento: value);
    emit(BeneficiarioLoaded(fechaNacimientoChanged));
  }

  void changePrimerNombre(String? newValue) {
    final primerNombreChanged = state.beneficiario?.copyWith(nombre1: newValue);
    emit(BeneficiarioLoaded(primerNombreChanged));
  }

  void changeSegundoNombre(String? newValue) {
    final segundoNombreChanged =
        state.beneficiario?.copyWith(nombre2: newValue);
    emit(BeneficiarioLoaded(segundoNombreChanged));
  }

  void changePrimerApellido(String? newValue) {
    final primerApellidoChanged =
        state.beneficiario?.copyWith(apellido1: newValue);
    emit(BeneficiarioLoaded(primerApellidoChanged));
  }

  void changeSegundoApellido(String? newValue) {
    final segundoApellidoChanged =
        state.beneficiario?.copyWith(apellido2: newValue);
    emit(BeneficiarioLoaded(segundoApellidoChanged));
  }

  void changeGenero(String? value) {
    final generoChanged = state.beneficiario?.copyWith(generoId: value);
    emit(BeneficiarioLoaded(generoChanged));
  }

  void changeGrupoEspecial(String value) {
    final grupoEspecialChanged =
        state.beneficiario?.copyWith(grupoEspecialId: value);
    emit(BeneficiarioLoaded(grupoEspecialChanged));
  }

  void changeTelefonoMovil(String? newValue) {
    final telefonoMovilChanged =
        state.beneficiario?.copyWith(telefonoMovil: newValue);
    emit(BeneficiarioLoaded(telefonoMovilChanged));
  }
}
