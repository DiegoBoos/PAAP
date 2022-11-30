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

  void selectPerfilBeneficiario(String perfilId, String beneficiarioId) async {
    final result = await perfilBeneficiarioDB.getPerfilBeneficiarioUsecaseDB(
        perfilId, beneficiarioId);
    result.fold(
        (failure) => emit(PerfilBeneficiarioError(failure.properties.first)),
        (data) {
      if (data == null) {
        emit(PerfilBeneficiarioError(
            'No se encontró el beneficiario relacionado al perfil'));
      } else {
        emit(PerfilBeneficiarioLoaded(data));
      }
    });
  }

  void loadPerfilBeneficiario(String perfilId, String beneficiarioId) async {
    final result = await perfilBeneficiarioDB.getPerfilBeneficiarioUsecaseDB(
        perfilId, beneficiarioId);
    result.fold(
        (failure) => emit(PerfilBeneficiarioError(failure.properties.first)),
        (data) {
      if (data != null) {
        emit(PerfilBeneficiarioLoaded(data));
      }
    });
  }

  void savePerfilBeneficiarioDB(
      PerfilBeneficiarioEntity perfilBeneficiarioEntity) async {
    final result = await perfilBeneficiarioDB
        .savePerfilBeneficiarioUsecaseDB(perfilBeneficiarioEntity);
    result.fold(
        (failure) => emit(PerfilBeneficiarioError(failure.properties.first)),
        (data) => emit(PerfilBeneficiarioSaved()));
  }

  void changeMunicipioId(String value) {
    final municipioChanged =
        state.perfilBeneficiario.copyWith(municipioId: value);
    emit(PerfilBeneficiarioChanged(municipioChanged));
  }

  void changeVeredaId(String value) {
    final veredaChanged = state.perfilBeneficiario.copyWith(veredaId: value);
    emit(PerfilBeneficiarioChanged(veredaChanged));
  }

  void changeTipoTenencia(String? value) {
    final tipoTenenciaChanged =
        state.perfilBeneficiario.copyWith(tipoTenenciaId: value);
    emit(PerfilBeneficiarioChanged(tipoTenenciaChanged));
  }

  void changeAreaFinca(String? newValue) {
    final areaFincaChanged =
        state.perfilBeneficiario.copyWith(areaFinca: newValue);
    emit(PerfilBeneficiarioChanged(areaFincaChanged));
  }

  void changeAreaProyecto(String? newValue) {
    final areaProyectoChanged =
        state.perfilBeneficiario.copyWith(areaProyecto: newValue);
    emit(PerfilBeneficiarioChanged(areaProyectoChanged));
  }

  void changeAsociado(bool? value) {
    final asociadoChanged =
        state.perfilBeneficiario.copyWith(asociado: value.toString());
    emit(PerfilBeneficiarioChanged(asociadoChanged));
  }

  void changeActivo(bool? value) {
    final tipoTenenciaChanged =
        state.perfilBeneficiario.copyWith(activo: value.toString());
    emit(PerfilBeneficiarioChanged(tipoTenenciaChanged));
  }

  void changeFueBeneficiado(bool? value) {
    final fueBeneficiadoChanged =
        state.perfilBeneficiario.copyWith(fueBeneficiado: value.toString());
    emit(PerfilBeneficiarioChanged(fueBeneficiadoChanged));
  }

  void changeCualBeneficio(String? newValue) {
    final cualBeneficioChanged =
        state.perfilBeneficiario.copyWith(cualBeneficio: newValue);
    emit(PerfilBeneficiarioChanged(cualBeneficioChanged));
  }

  void changeExperiencia(String? newValue) {
    final experienciaChanged =
        state.perfilBeneficiario.copyWith(experiencia: newValue);
    emit(PerfilBeneficiarioChanged(experienciaChanged));
  }

  void changePerfilId(String value) {
    final perfilIdChanged = state.perfilBeneficiario.copyWith(perfilId: value);
    emit(PerfilBeneficiarioChanged(perfilIdChanged));
  }

  void changeBeneficiarioId(String value) {
    final beneficiarioIdChanged =
        state.perfilBeneficiario.copyWith(beneficiarioId: value);
    emit(PerfilBeneficiarioChanged(beneficiarioIdChanged));
  }
}
