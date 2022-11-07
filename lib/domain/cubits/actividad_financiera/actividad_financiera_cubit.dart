import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/actividad_financiera_entity.dart';
import '../../usecases/actividad_financiera/actividad_financiera_db_usecase.dart';
import '../../usecases/actividad_financiera/actividad_financiera_usecase.dart';

part '../actividad_financiera/actividad_financiera_state.dart';

class ActividadFinancieraCubit extends Cubit<ActividadFinancieraState> {
  final ActividadFinancieraUsecase actividadFinanciera;
  final ActividadFinancieraUsecaseDB actividadFinancieraDB;

  ActividadFinancieraCubit(
      {required this.actividadFinanciera, required this.actividadFinancieraDB})
      : super(ActividadFinancieraInitial()) {
    getActividadFinancieraDB();
  }

  void getActividadFinancieraDB() async {
    final result =
        await actividadFinancieraDB.getActividadFinancierasUsecaseDB();
    result.fold(
        (failure) => emit(ActividadFinancieraError(failure.properties.first)),
        (data) => emit(ActividadFinancieraLoaded(data)));
  }
}
