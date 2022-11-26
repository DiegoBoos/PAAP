import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_cofinanciador_actividad_financiera_entity.dart';
import '../../usecases/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_db_usecase.dart';

part '../perfil_preinversion_cofinanciador_actividades_financieras/perfil_preinversion_cofinanciador_actividades_financieras_event.dart';
part '../perfil_preinversion_cofinanciador_actividades_financieras/perfil_preinversion_cofinanciador_actividades_financieras_state.dart';

class PerfilPreInversionCofinanciadorActividadesFinancierasBloc extends Bloc<
    PerfilPreInversionCofinanciadorActividadesFinancierasEvent,
    PerfilPreInversionCofinanciadorActividadesFinancierasState> {
  final PerfilPreInversionCofinanciadorActividadFinancieraUsecaseDB
      perfilPreInversionCofinanciadorActividadFinancieraUsecaseDB;

  PerfilPreInversionCofinanciadorActividadesFinancierasBloc(
      {required this.perfilPreInversionCofinanciadorActividadFinancieraUsecaseDB})
      : super(PerfilPreInversionCofinanciadorActividadesFinancierasInitial()) {
    on<GetPerfilPreInversionCofinanciadorActividadesFinancieras>(
        (event, emit) async {
      emit(PerfilPreInversionCofinanciadorActividadesFinancierasLoading());
      await _getPerfilPreInversionCofinanciadorActividadesFinancieras(
          event, emit);
    });

    on<GetPerfilPreInversionCofinanciadorActividadesFinancierasByCofinanciador>(
        (event, emit) async {
      emit(PerfilPreInversionCofinanciadorActividadesFinancierasLoading());
      await _getPerfilPreInversionCofinanciadorActividadesFinancierasByCofinanciador(
          event, emit);
    });
  }

  _getPerfilPreInversionCofinanciadorActividadesFinancieras(event, emit) async {
    final result =
        await perfilPreInversionCofinanciadorActividadFinancieraUsecaseDB
            .getPerfilPreInversionCofinanciadorActividadesFinancierasUsecaseDB();
    result.fold(
        (failure) => emit(
            PerfilPreInversionCofinanciadorActividadesFinancierasError(
                failure.properties.first)),
        (data) => emit(
            PerfilPreInversionCofinanciadorActividadesFinancierasLoaded(data)));
  }

  _getPerfilPreInversionCofinanciadorActividadesFinancierasByCofinanciador(
      event, emit) async {
    final result = await perfilPreInversionCofinanciadorActividadFinancieraUsecaseDB
        .getPerfilPreInversionCofinanciadorActividadesFinancierasByCofinanciadorUsecaseDB(
            event.perfilPreInversionId,
            event.cofinanciadorId,
            event.actividadFinancieraId,
            event.desembolsoId);
    result.fold(
        (failure) => emit(
            PerfilPreInversionCofinanciadorActividadesFinancierasError(
                failure.properties.first)),
        (data) => emit(
            PerfilPreInversionCofinanciadorActividadesFinancierasLoaded(data)));
  }
}
