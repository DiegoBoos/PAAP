import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tipo_movimiento_entity.dart';
import '../../../domain/usecases/tipo_movimiento/tipo_movimiento_db_usecase.dart';
part '../tipo_movimiento/tipo_movimiento_state.dart';

class TipoMovimientoCubit extends Cubit<TipoMovimientoState> {
  final TipoMovimientoUsecaseDB tipoMovimientoDB;

  TipoMovimientoCubit({required this.tipoMovimientoDB})
      : super(TiposMovimientosInitial()) {
    getTiposMovimientosDB();
  }

  void getTiposMovimientosDB() async {
    final result = await tipoMovimientoDB.getTiposMovimientosUsecaseDB();
    result.fold(
        (failure) => emit(TiposMovimientosError(failure.properties.first)),
        (data) => emit(TiposMovimientosLoaded(data)));
  }
}
