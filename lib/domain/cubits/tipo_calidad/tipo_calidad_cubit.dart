import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/tipo_calidad_entity.dart';
import '../../usecases/tipo_calidad/tipo_calidad_db_usecase.dart';

part '../tipo_calidad/tipo_calidad_state.dart';

class TipoCalidadCubit extends Cubit<TipoCalidadState> {
  final TipoCalidadUsecaseDB tipoCalidadDB;

  TipoCalidadCubit({required this.tipoCalidadDB})
      : super(TiposCalidadesInitial()) {
    getTiposCalidadesDB();
  }

  void getTiposCalidadesDB() async {
    final result = await tipoCalidadDB.getTiposCalidadesUsecaseDB();
    result.fold(
        (failure) => emit(TiposCalidadesError(failure.properties.first)),
        (data) => emit(TiposCalidadesLoaded(data)));
  }
}
