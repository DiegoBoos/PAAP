import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_plan_negocio_entity.dart';
import '../../usecases/perfil_preinversion_plan_negocio/perfil_preinversion_plan_negocio_db_usecase.dart';

part 'perfil_preinversion_planes_negocios_event.dart';
part 'perfil_preinversion_planes_negocios_state.dart';

class PerfilPreInversionPlanNegociosBloc extends Bloc<
    PerfilPreInversionPlanNegociosEvent, PerfilPreInversionPlanNegociosState> {
  final PerfilPreInversionPlanNegocioUsecaseDB
      perfilPreInversionPlanNegocioUsecaseDB;
  PerfilPreInversionPlanNegociosBloc(
      {required this.perfilPreInversionPlanNegocioUsecaseDB})
      : super(PerfilPreInversionPlanNegociosInitial()) {
    on<GetPerfilPreInversionPlanNegocios>((event, emit) async {
      emit(PerfilPreInversionPlanNegociosLoading());
      await _getPerfilPreInversionPlanNegocios(event, emit);
    });
  }
  _getPerfilPreInversionPlanNegocios(event, emit) async {
    final result = await perfilPreInversionPlanNegocioUsecaseDB
        .getPerfilPreInversionPlanNegociosUsecaseDB();
    result.fold(
        (failure) =>
            emit(PerfilPreInversionPlanNegociosError(failure.properties.first)),
        (data) => emit(PerfilPreInversionPlanNegociosLoaded(data)));
  }
}
