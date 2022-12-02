import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_plan_negocio_entity.dart';
import '../../usecases/perfil_preinversion_plan_negocio/perfil_preinversion_plan_negocio_db_usecase.dart';

part 'perfil_preinversion_planes_negocios_event.dart';
part 'perfil_preinversion_planes_negocios_state.dart';

class PerfilPreInversionPlanesNegociosBloc extends Bloc<
    PerfilPreInversionPlanesNegociosEvent,
    PerfilPreInversionPlanesNegociosState> {
  final PerfilPreInversionPlanNegocioUsecaseDB
      perfilPreInversionPlanNegocioUsecaseDB;
  PerfilPreInversionPlanesNegociosBloc(
      {required this.perfilPreInversionPlanNegocioUsecaseDB})
      : super(PerfilPreInversionPlanesNegociosInitial()) {
    on<GetPerfilPreInversionPlanesNegocios>((event, emit) async {
      emit(PerfilPreInversionPlanesNegociosLoading());
      await _getPerfilPreInversionplanesNegocios(event, emit);
    });
  }
  _getPerfilPreInversionplanesNegocios(event, emit) async {
    final result = await perfilPreInversionPlanNegocioUsecaseDB
        .getPerfilPreInversionplanesNegociosUsecaseDB();
    result.fold(
        (failure) => emit(
            PerfilPreInversionPlanesNegociosError(failure.properties.first)),
        (data) => emit(PerfilPreInversionPlanesNegociosLoaded(data)));
  }
}
