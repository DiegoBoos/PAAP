import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_beneficiario_entity.dart';
import '../../usecases/perfil_beneficiario/perfil_beneficiario_db_usecase.dart';

part '../perfil_beneficiario/perfil_beneficiario_state.dart';

class PerfilBeneficiarioCubit extends Cubit<PerfilBeneficiarioState> {
  final PerfilBeneficiarioUsecaseDB perfilBeneficiarioDB;

  PerfilBeneficiarioCubit({required this.perfilBeneficiarioDB})
      : super(PerfilBeneficiarioInitial());

  void initState() => emit(PerfilBeneficiarioInitial());

  void selectPerfilBeneficiario(String beneficiarioId) async {
    final result = await perfilBeneficiarioDB
        .getPerfilBeneficiarioUsecaseDB(beneficiarioId);
    result.fold(
        (failure) => emit(PerfilBeneficiarioError(failure.properties.first)),
        (data) => emit(PerfilBeneficiarioLoaded(data)));
  }

  void changeTipoTenencia(String? value) {
    final tipoTenenciaChanged =
        state.perfilBeneficiario?.copyWith(tipoTenenciaId: value);
    emit(PerfilBeneficiarioLoaded(tipoTenenciaChanged));
  }

  void changeAreaFinca(String? newValue) {
    final areaFincaChanged =
        state.perfilBeneficiario?.copyWith(areaFinca: newValue);
    emit(PerfilBeneficiarioLoaded(areaFincaChanged));
  }

  void changeAreaProyecto(String? newValue) {
    final areaProyectoChanged =
        state.perfilBeneficiario?.copyWith(areaProyecto: newValue);
    emit(PerfilBeneficiarioLoaded(areaProyectoChanged));
  }

  void changeAsociado(bool? value) {
    final asociadoChanged =
        state.perfilBeneficiario?.copyWith(asociado: value.toString());
    emit(PerfilBeneficiarioLoaded(asociadoChanged));
  }

  void changeActivo(bool? value) {
    final tipoTenenciaChanged =
        state.perfilBeneficiario?.copyWith(activo: value.toString());
    emit(PerfilBeneficiarioLoaded(tipoTenenciaChanged));
  }

  void changeFueBeneficiado(bool? value) {
    final fueBeneficiadoChanged =
        state.perfilBeneficiario?.copyWith(fueBeneficiado: value.toString());
    emit(PerfilBeneficiarioLoaded(fueBeneficiadoChanged));
  }

  void changeCualBeneficio(String? newValue) {
    final cualBeneficioChanged =
        state.perfilBeneficiario?.copyWith(cualBeneficio: newValue);
    emit(PerfilBeneficiarioLoaded(cualBeneficioChanged));
  }

  void changeExperiencia(String? newValue) {
    final experienciaChanged =
        state.perfilBeneficiario?.copyWith(experiencia: newValue);
    emit(PerfilBeneficiarioLoaded(experienciaChanged));
  }
}
