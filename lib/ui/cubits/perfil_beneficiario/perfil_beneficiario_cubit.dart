import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/perfil_beneficiario_entity.dart';
import '../../../domain/usecases/perfil_beneficiario/perfil_beneficiario_db_usecase.dart';

part '../perfil_beneficiario/perfil_beneficiario_state.dart';

class PerfilBeneficiarioCubit extends Cubit<PerfilBeneficiarioState> {
  final PerfilBeneficiarioUsecaseDB perfilBeneficiarioDB;

  PerfilBeneficiarioCubit({required this.perfilBeneficiarioDB})
      : super(PerfilBeneficiarioInitial());

  void initState() => emit(PerfilBeneficiarioInitial());

  void setPerfilBeneficiario(PerfilBeneficiarioEntity perfilBeneficiario) {
    emit(PerfilBeneficiarioChanged(perfilBeneficiario));
  }

  void loadPerfilBeneficiario(String perfilId, String beneficiarioId) async {
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

  void savePerfilBeneficiarioDB() async {
    final result = await perfilBeneficiarioDB
        .savePerfilBeneficiarioUsecaseDB(state.perfilBeneficiario);
    result.fold(
        (failure) => emit(PerfilBeneficiarioError(failure.properties.first)),
        (data) => emit(PerfilBeneficiarioSaved(
            perfilBeneficiario: state.perfilBeneficiario)));
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

  void changeAsociado(String? value) {
    final asociadoChanged = state.perfilBeneficiario.copyWith(asociado: value);
    emit(PerfilBeneficiarioChanged(asociadoChanged));
  }

  void changeActivo(String? value) {
    final activoChanged = state.perfilBeneficiario.copyWith(activo: value);
    emit(PerfilBeneficiarioChanged(activoChanged));
  }

  void changeFueBeneficiado(String? value) {
    final fueBeneficiadoChanged =
        state.perfilBeneficiario.copyWith(fueBeneficiado: value);
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

  void changePerfilId(String? newValue) {
    final perfilIdChanged =
        state.perfilBeneficiario.copyWith(perfilId: newValue);
    emit(PerfilBeneficiarioChanged(perfilIdChanged));
  }

  void changeBeneficiarioId(String? newValue) {
    final beneficiarioIdChanged =
        state.perfilBeneficiario.copyWith(beneficiarioId: newValue);
    emit(PerfilBeneficiarioChanged(beneficiarioIdChanged));
  }
}
