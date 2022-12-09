import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/v_perfil_preinversion_plan_negocio_entity.dart';
import '../../usecases/perfil_preinversion_plan_negocio/perfil_preinversion_plan_negocio_db_usecase.dart';

part 'v_perfiles_preinversiones_plan_negocios_state.dart';

class VPerfilesPreInversionesPlanNegociosCubit
    extends Cubit<VPerfilesPreInversionesPlanNegociosState> {
  final PerfilPreInversionPlanNegocioUsecaseDB
      vPerfilesPreInversionesPlanNegociosDB;

  VPerfilesPreInversionesPlanNegociosCubit(
      {required this.vPerfilesPreInversionesPlanNegociosDB})
      : super(VPerfilesPreInversionesPlanNegociosInitial());

  void initState() => emit(VPerfilesPreInversionesPlanNegociosInitial());

  void getVPerfilesPreInversionesPlanNegociosDB(
      String perfilPreInversionId, String tipoMovimientoId) async {
    final result = await vPerfilesPreInversionesPlanNegociosDB
        .getVPerfilesPreInversionesPlanNegociosUsecaseDB(
            perfilPreInversionId, tipoMovimientoId);
    result.fold(
        (failure) => emit(
            VPerfilesPreInversionesPlanNegociosError(failure.properties.first)),
        (data) {
      emit(VPerfilesPreInversionesPlanNegociosLoaded(data));
    });
  }
}
