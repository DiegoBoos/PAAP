part of 'opcion_cubit.dart';

abstract class OpcionState extends Equatable {
  final List<OpcionEntity>? opciones;
  const OpcionState({this.opciones});

  @override
  List<Object?> get props => [opciones];
}

class OpcionesInitial extends OpcionState {}

class OpcionesLoading extends OpcionState {}

class OpcionesLoaded extends OpcionState {
  final List<OpcionEntity>? opcionesLoaded;

  const OpcionesLoaded(this.opcionesLoaded) : super(opciones: opcionesLoaded);
}

class OpcionesError extends OpcionState {
  final String message;

  const OpcionesError(this.message);

  @override
  List<Object?> get props => [message];
}
