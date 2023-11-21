import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/actividad_financiera_entity.dart';
import '../../../domain/usecases/actividad_financiera/actividad_financiera_db_usecase.dart';

part '../actividad_financiera/actividad_financiera_state.dart';

class ActividadFinancieraCubit extends Cubit<ActividadFinancieraState> {
  final ActividadFinancieraUsecaseDB actividadFinancieraDB;

  ActividadFinancieraCubit({required this.actividadFinancieraDB})
      : super(ActividadesFinancierasInitial()) {
    getActividadesFinancierasDB();
  }

  void getActividadesFinancierasDB() async {
    final result =
        await actividadFinancieraDB.getActividadesFinancierasUsecaseDB();
    result.fold(
        (failure) => emit(ActividadFinancieraError(failure.properties.first)),
        (data) => emit(ActividadesFinancierasLoaded(data)));
  }
}
