import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_cofinanciador_actividad_financiera_entity.dart';
import '../../usecases/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_db_usecase.dart';

part 'perfil_preinversion_cofinanciador_actividad_financiera_state.dart';

class PerfilPreInversionCofinanciadorActividadFinancieraCubit
    extends Cubit<PerfilPreInversionCofinanciadorActividadFinancieraState> {
  final PerfilPreInversionCofinanciadorActividadFinancieraUsecaseDB
      perfilPreInversionCofinanciadorActividadFinancieraDB;

  PerfilPreInversionCofinanciadorActividadFinancieraCubit(
      {required this.perfilPreInversionCofinanciadorActividadFinancieraDB})
      : super(PerfilPreInversionCofinanciadorActividadFinancieraInitial());

  void initState() =>
      emit(PerfilPreInversionCofinanciadorActividadFinancieraInitial());

  void selectPerfilPreInversionCofinanciadorActividadFinanciera(
      String cofinanciadorId) async {
    final result = await perfilPreInversionCofinanciadorActividadFinancieraDB
        .getPerfilPreInversionCofinanciadorActividadFinancieraUsecaseDB(
            cofinanciadorId);
    result.fold(
        (failure) => emit(
            PerfilPreInversionCofinanciadorActividadFinancieraError(
                failure.properties.first)),
        (data) => emit(
            PerfilPreInversionCofinanciadorActividadFinancieraLoaded(data)));
  }

  void changeActividadFinanciera(String? value) {
    final actividadFinancieraChanged = state
        .perfilPreInversionCofinanciadorActividadFinanciera
        ?.copyWith(actividadFinancieraId: value);
    emit(PerfilPreInversionCofinanciadorActividadFinancieraLoaded(
        actividadFinancieraChanged));
  }

  void changeValor(String? text) {
    final valorChanged = state
        .perfilPreInversionCofinanciadorActividadFinanciera
        ?.copyWith(valor: text);
    emit(
        PerfilPreInversionCofinanciadorActividadFinancieraLoaded(valorChanged));
  }
}
