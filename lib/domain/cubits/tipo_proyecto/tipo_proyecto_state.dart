part of 'tipo_proyecto_cubit.dart';

abstract class TipoProyectoState extends Equatable {
  final List<TipoProyectoEntity>? tipoProyecto;
  const TipoProyectoState({this.tipoProyecto});

  @override
  List<Object?> get props => [tipoProyecto];
}

class TipoProyectoInitial extends TipoProyectoState {}

class TipoProyectoLoading extends TipoProyectoState {}

class TipoProyectoLoaded extends TipoProyectoState {
  final List<TipoProyectoEntity>? tipoProyectoLoaded;

  const TipoProyectoLoaded(this.tipoProyectoLoaded)
      : super(tipoProyecto: tipoProyectoLoaded);
}

class TipoProyectoError extends TipoProyectoState {
  final String message;

  const TipoProyectoError(this.message);

  @override
  List<Object?> get props => [message];
}
