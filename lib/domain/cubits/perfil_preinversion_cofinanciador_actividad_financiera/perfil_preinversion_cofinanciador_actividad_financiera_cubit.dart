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
      : super(PerfilPreInversionCofinanciadorActividadesFinancierasInitial());

  void getPerfilPreInversionCofinanciadorActividadesFinancierasDB() async {
    final result = await perfilPreInversionCofinanciadorActividadFinancieraDB
        .getPerfilPreInversionCofinanciadorActividadesFinancierasUsecaseDB();
    result.fold(
        (failure) => emit(
            PerfilPreInversionCofinanciadorActividadesFinancierasError(
                failure.properties.first)),
        (data) => emit(
            PerfilPreInversionCofinanciadorActividadesFinancierasLoaded(data)));
  }

  void initState() =>
      emit(PerfilPreInversionCofinanciadorActividadesFinancierasInitial());
}
