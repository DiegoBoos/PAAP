import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_plan_negocio_entity.dart';
import '../../usecases/perfil_preinversion_plan_negocio/perfil_preinversion_plan_negocio_db_usecase.dart';

part 'perfil_preinversion_plan_negocio_state.dart';

class PerfilPreInversionPlanNegocioCubit
    extends Cubit<PerfilPreInversionPlanNegocioState> {
  final PerfilPreInversionPlanNegocioUsecaseDB perfilPreInversionPlanNegocioDB;

  PerfilPreInversionPlanNegocioCubit(
      {required this.perfilPreInversionPlanNegocioDB})
      : super(PerfilPreInversionPlanNegociosInitial());

  void getPerfilPreInversionPlanNegociosDB() async {
    final result = await perfilPreInversionPlanNegocioDB
        .getPerfilPreInversionPlanNegociosUsecaseDB();
    result.fold(
        (failure) =>
            emit(PerfilPreInversionPlanNegocioError(failure.properties.first)),
        (data) => emit(PerfilPreInversionPlanNegociosLoaded(data)));
  }

  void savePerfilPreInversionPlanNegocioDB(
      PerfilPreInversionPlanNegocioEntity
          perfilPreInversionPlanNegocioEntity) async {
    final result = await perfilPreInversionPlanNegocioDB
        .savePerfilPreInversionPlanNegocioUsecaseDB(
            perfilPreInversionPlanNegocioEntity);
    result.fold(
        (failure) =>
            emit(PerfilPreInversionPlanNegocioError(failure.properties.first)),
        (data) => emit(PerfilPreInversionPlanNegocioSaved()));
  }

  void initState() => emit(PerfilPreInversionPlanNegociosInitial());
}
