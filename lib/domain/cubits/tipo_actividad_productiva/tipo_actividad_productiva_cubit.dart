import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/tipo_actividad_productiva_entity.dart';
import '../../usecases/tipo_actividad_productiva/tipo_actividad_productiva_db_usecase.dart';

part 'tipo_actividad_productiva_state.dart';

class TipoActividadProductivaCubit extends Cubit<TipoActividadProductivaState> {
  final TipoActividadProductivaUsecaseDB tipoActividadProductivaDB;

  TipoActividadProductivaCubit({required this.tipoActividadProductivaDB})
      : super(TiposActividadesProductivasInitial()) {
    getTiposActividadesProductivaDB();
  }

  void getTiposActividadesProductivaDB() async {
    final result = await tipoActividadProductivaDB
        .getTiposActividadesProductivasUsecaseDB();
    result.fold(
        (failure) =>
            emit(TiposActividadesProductivasError(failure.properties.first)),
        (data) => emit(TiposActividadesProductivasLoaded(data)));
  }
}
