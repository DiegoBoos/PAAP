part of 'tipo_movimiento_cubit.dart';

abstract class TipoMovimientoState extends Equatable {
  final List<TipoMovimientoEntity>? tiposMovimientos;
  const TipoMovimientoState({this.tiposMovimientos});

  @override
  List<Object?> get props => [tiposMovimientos];
}

class TiposMovimientosInitial extends TipoMovimientoState {}

class TiposMovimientosLoading extends TipoMovimientoState {}

class TiposMovimientosLoaded extends TipoMovimientoState {
  final List<TipoMovimientoEntity>? tiposMovimientosLoaded;

  const TiposMovimientosLoaded(this.tiposMovimientosLoaded)
      : super(tiposMovimientos: tiposMovimientosLoaded);
}

class TiposMovimientosError extends TipoMovimientoState {
  final String message;

  const TiposMovimientosError(this.message);

  @override
  List<Object?> get props => [message];
}
