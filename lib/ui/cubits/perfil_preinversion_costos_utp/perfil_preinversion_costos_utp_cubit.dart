import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/perfil_preinversion_plan_negocio_entity.dart';
import '../../../domain/entities/v_perfil_preinversion_plan_negocio_entity.dart';
import '../../../domain/usecases/perfil_preinversion_plan_negocio/perfil_preinversion_plan_negocio_db_usecase.dart';

part 'perfil_preinversion_costos_utp_state.dart';

class PerfilPreInversionCostosUPTCubit
    extends Cubit<PerfilPreInversionCostosUPTState> {
  final PerfilPreInversionPlanNegocioUsecaseDB perfilPreInversionPlanNegocioDB;

  PerfilPreInversionCostosUPTCubit(
      {required this.perfilPreInversionPlanNegocioDB})
      : super(PerfilPreInversionCostosUPTInitial());

  void initState() => emit(PerfilPreInversionCostosUPTInitial());

  selectPerfilPreInversionCostosUPT(
      VPerfilPreInversionPlanNegocioEntity vPerfilPreInversionPlanNegocio) {
    emit(PerfilPreInversionCostosUPTLoaded(vPerfilPreInversionPlanNegocio));
  }

  void savePerfilPreInversionCostosUPTDB(
      PerfilPreInversionPlanNegocioEntity perfilPreInversionPlanNegocioEntity,
      String tipoMovimientoId) async {
    final result = await perfilPreInversionPlanNegocioDB
        .savePerfilPreInversionPlanNegocioUsecaseDB(
            perfilPreInversionPlanNegocioEntity, tipoMovimientoId);
    result.fold(
        (failure) =>
            emit(PerfilPreInversionCostosUPTError(failure.properties.first)),
        (data) => emit(PerfilPreInversionCostosUPTSaved(
            perfilPreInversionCostosUPT: data)));
  }

  void changeRubro(String? value) {
    final rubroChanged =
        state.perfilPreInversionCostosUPT.copyWith(rubroId: value);
    emit(PerfilPreInversionCostosUPTChanged(rubroChanged));
  }

  void changeUnidad(String? value) {
    final unidadChanged =
        state.perfilPreInversionCostosUPT.copyWith(unidadId: value);
    emit(PerfilPreInversionCostosUPTChanged(unidadChanged));
  }

  void changeYear(String? newValue) {
    final yearChanged =
        state.perfilPreInversionCostosUPT.copyWith(year: newValue);
    emit(PerfilPreInversionCostosUPTChanged(yearChanged));
  }

  void changeCantidad(String? newValue) {
    final cantidadChanged =
        state.perfilPreInversionCostosUPT.copyWith(cantidad: newValue);
    emit(PerfilPreInversionCostosUPTChanged(cantidadChanged));
  }

  void changeValor(String? newValue) {
    final valorChanged =
        state.perfilPreInversionCostosUPT.copyWith(valor: newValue);
    emit(PerfilPreInversionCostosUPTChanged(valorChanged));
  }
}
