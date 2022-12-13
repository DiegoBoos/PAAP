import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_plan_negocio_entity.dart';
import '../../entities/v_perfil_preinversion_plan_negocio_entity.dart';
import '../../usecases/perfil_preinversion_plan_negocio/perfil_preinversion_plan_negocio_db_usecase.dart';

part 'perfil_preinversion_ingresos_utp_state.dart';

class PerfilPreInversionIngresosUPTCubit
    extends Cubit<PerfilPreInversionIngresosUPTState> {
  final PerfilPreInversionPlanNegocioUsecaseDB perfilPreInversionPlanNegocioDB;

  PerfilPreInversionIngresosUPTCubit(
      {required this.perfilPreInversionPlanNegocioDB})
      : super(PerfilPreInversionIngresosUPTInitial());

  void initState() => emit(PerfilPreInversionIngresosUPTInitial());

  selectPerfilPreInversionIngresosUPT(
      VPerfilPreInversionPlanNegocioEntity vPerfilPreInversionPlanNegocio) {
    emit(PerfilPreInversionIngresosUPTLoaded(vPerfilPreInversionPlanNegocio));
  }

  void savePerfilPreInversionIngresosUPTDB(
      PerfilPreInversionPlanNegocioEntity perfilPreInversionPlanNegocioEntity,
      String tipoMovimientoId) async {
    final result = await perfilPreInversionPlanNegocioDB
        .savePerfilPreInversionPlanNegocioUsecaseDB(
            perfilPreInversionPlanNegocioEntity, tipoMovimientoId);
    result.fold(
        (failure) =>
            emit(PerfilPreInversionIngresosUPTError(failure.properties.first)),
        (data) => emit(PerfilPreInversionIngresosUPTSaved(
            perfilPreInversionIngresosUPT: data)));
  }

  void changeRubro(String? value) {
    final rubroChanged =
        state.perfilPreInversionIngresosUPT.copyWith(rubroId: value);
    emit(PerfilPreInversionIngresosUPTChanged(rubroChanged));
  }

  void changeUnidad(String? value) {
    final unidadChanged =
        state.perfilPreInversionIngresosUPT.copyWith(unidadId: value);
    emit(PerfilPreInversionIngresosUPTChanged(unidadChanged));
  }

  void changeYear(String? newValue) {
    final yearChanged =
        state.perfilPreInversionIngresosUPT.copyWith(year: newValue);
    emit(PerfilPreInversionIngresosUPTChanged(yearChanged));
  }

  void changeCantidad(String? newValue) {
    final cantidadChanged =
        state.perfilPreInversionIngresosUPT.copyWith(cantidad: newValue);
    emit(PerfilPreInversionIngresosUPTChanged(cantidadChanged));
  }

  void changeValor(String? newValue) {
    final valorChanged =
        state.perfilPreInversionIngresosUPT.copyWith(valor: newValue);
    emit(PerfilPreInversionIngresosUPTChanged(valorChanged));
  }

  void changeProducto(String? value) {
    final productoChanged =
        state.perfilPreInversionIngresosUPT.copyWith(productoId: value);
    emit(PerfilPreInversionIngresosUPTChanged(productoChanged));
  }

  void changeTipoCalidad(String? value) {
    final tipoCalidadChanged =
        state.perfilPreInversionIngresosUPT.copyWith(tipoCalidadId: value);
    emit(PerfilPreInversionIngresosUPTChanged(tipoCalidadChanged));
  }
}
