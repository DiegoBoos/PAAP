import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tipo_discapacidad_entity.dart';
import '../../../domain/usecases/tipo_discapacidad/tipo_discapacidad_db_usecase.dart';

part 'tipo_discapacidad_state.dart';

class TipoDiscapacidadCubit extends Cubit<TipoDiscapacidadState> {
  final TipoDiscapacidadUsecaseDB tipoDiscapacidadDB;

  TipoDiscapacidadCubit({required this.tipoDiscapacidadDB})
      : super(TiposDiscapacidadesInitial()) {
    getTiposDiscapacidadesDB();
  }

  void getTiposDiscapacidadesDB() async {
    final result = await tipoDiscapacidadDB.getTiposDiscapacidadesUsecaseDB();
    result.fold(
        (failure) => emit(TiposDiscapacidadesError(failure.properties.first)),
        (data) => emit(TiposDiscapacidadesLoaded(data)));
  }
}
