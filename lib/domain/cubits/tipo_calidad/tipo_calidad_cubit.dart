import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/tipo_calidad_entity.dart';
import '../../usecases/tipo_calidad/tipo_calidad_db_usecase.dart';
import '../../usecases/tipo_calidad/tipo_calidad_usecase.dart';

part '../tipo_calidad/tipo_calidad_state.dart';

class TipoCalidadCubit extends Cubit<TipoCalidadState> {
  final TipoCalidadUsecase tipoCalidad;
  final TipoCalidadUsecaseDB tipoCalidadDB;

  TipoCalidadCubit({required this.tipoCalidad, required this.tipoCalidadDB})
      : super(TipoCalidadInitial()) {
    getTipoCalidadDB();
  }

  void getTipoCalidadDB() async {
    final result = await tipoCalidadDB.getTiposCalidadesUsecaseDB();
    result.fold((failure) => emit(TipoCalidadError(failure.properties.first)),
        (data) => emit(TipoCalidadLoaded(data)));
  }
}
