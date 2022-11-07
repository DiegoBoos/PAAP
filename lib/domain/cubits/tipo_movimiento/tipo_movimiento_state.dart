part of 'tipo_movimiento_cubit.dart';

abstract class TipoMovimientoState extends Equatable {
  final List<TipoMovimientoEntity>? tipoMovimiento;
  const TipoMovimientoState({this.tipoMovimiento});

  @override
  List<Object?> get props => [tipoMovimiento];
}

class TipoMovimientoInitial extends TipoMovimientoState {}

class TipoMovimientoLoading extends TipoMovimientoState {}

class TipoMovimientoLoaded extends TipoMovimientoState {
  final List<TipoMovimientoEntity>? tipoMovimientoLoaded;

  const TipoMovimientoLoaded(this.tipoMovimientoLoaded)
      : super(tipoMovimiento: tipoMovimientoLoaded);
}

class TipoMovimientoError extends TipoMovimientoState {
  final String message;

  const TipoMovimientoError(this.message);

  @override
  List<Object?> get props => [message];
}
