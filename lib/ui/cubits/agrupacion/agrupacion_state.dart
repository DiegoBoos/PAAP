part of 'agrupacion_cubit.dart';

abstract class AgrupacionState extends Equatable {
  final List<AgrupacionEntity>? agrupaciones;
  const AgrupacionState({this.agrupaciones});

  @override
  List<Object?> get props => [agrupaciones];
}

class AgrupacionesInitial extends AgrupacionState {}

class AgrupacionesLoading extends AgrupacionState {}

class AgrupacionesLoaded extends AgrupacionState {
  final List<AgrupacionEntity>? agrupacionesLoaded;

  const AgrupacionesLoaded(this.agrupacionesLoaded)
      : super(agrupaciones: agrupacionesLoaded);
}

class AgrupacionesError extends AgrupacionState {
  final String message;

  const AgrupacionesError(this.message);

  @override
  List<Object?> get props => [message];
}
