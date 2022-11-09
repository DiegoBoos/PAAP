import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/actividad_economica_entity.dart';
import '../../usecases/actividad_economica/actividad_economica_db_usecase.dart';

part 'actividad_economica_state.dart';

class ActividadEconomicaCubit extends Cubit<ActividadEconomicaState> {
  final ActividadEconomicaUsecaseDB actividadEconomicaDB;

  ActividadEconomicaCubit({required this.actividadEconomicaDB})
      : super(ActividadesEconomicasInitial()) {
    getActividadesEconomicasDB();
  }

  void getActividadesEconomicasDB() async {
    final result = await actividadEconomicaDB.getActividadEconomicasUsecaseDB();
    result.fold(
        (failure) => emit(ActividadesEconomicasError(failure.properties.first)),
        (data) => emit(ActividadesEconomicasLoaded(data)));
  }
}
