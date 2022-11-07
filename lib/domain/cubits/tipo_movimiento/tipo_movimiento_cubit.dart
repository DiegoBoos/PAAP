import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/tipo_movimiento_entity.dart';
import '../../usecases/tipo_movimiento/tipo_movimiento_db_usecase.dart';
import '../../usecases/tipo_movimiento/tipo_movimiento_usecase.dart';

part '../tipo_movimiento/tipo_movimiento_state.dart';

class TipoMovimientoCubit extends Cubit<TipoMovimientoState> {
  final TipoMovimientoUsecase tipoMovimiento;
  final TipoMovimientoUsecaseDB tipoMovimientoDB;

  TipoMovimientoCubit(
      {required this.tipoMovimiento, required this.tipoMovimientoDB})
      : super(TipoMovimientoInitial()) {
    getTipoMovimientoDB();
  }

  void getTipoMovimientoDB() async {
    final result = await tipoMovimientoDB.getTiposMovimientosUsecaseDB();
    result.fold(
        (failure) => emit(TipoMovimientoError(failure.properties.first)),
        (data) => emit(TipoMovimientoLoaded(data)));
  }
}
