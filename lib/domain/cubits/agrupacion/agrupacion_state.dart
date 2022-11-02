part of 'agrupacion_cubit.dart';

abstract class AgrupacionState extends Equatable {
  final List<AgrupacionEntity>? agrupacion;
  const AgrupacionState({this.agrupacion});

  @override
  List<Object?> get props => [agrupacion];
}

class AgrupacionInitial extends AgrupacionState {}

class AgrupacionLoading extends AgrupacionState {}

class AgrupacionLoaded extends AgrupacionState {
  final List<AgrupacionEntity>? agrupacionLoaded;

  const AgrupacionLoaded(this.agrupacionLoaded)
      : super(agrupacion: agrupacionLoaded);
}

class AgrupacionError extends AgrupacionState {
  final String message;

  const AgrupacionError(this.message);

  @override
  List<Object?> get props => [message];
}
