part of 'estado_civil_cubit.dart';

abstract class EstadoCivilState extends Equatable {
  final List<EstadoCivilEntity>? estadoCivil;
  const EstadoCivilState({this.estadoCivil});

  @override
  List<Object?> get props => [estadoCivil];
}

class EstadoCivilInitial extends EstadoCivilState {}

class EstadoCivilLoading extends EstadoCivilState {}

class EstadoCivilLoaded extends EstadoCivilState {
  final List<EstadoCivilEntity>? estadoCivilLoaded;

  const EstadoCivilLoaded(this.estadoCivilLoaded)
      : super(estadoCivil: estadoCivilLoaded);
}

class EstadoCivilError extends EstadoCivilState {
  final String message;

  const EstadoCivilError(this.message);

  @override
  List<Object?> get props => [message];
}
