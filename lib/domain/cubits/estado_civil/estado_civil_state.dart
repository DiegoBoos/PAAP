part of 'estado_civil_cubit.dart';

abstract class EstadoCivilState extends Equatable {
  final List<EstadoCivilEntity>? estadosCiviles;
  const EstadoCivilState({this.estadosCiviles});

  @override
  List<Object?> get props => [estadosCiviles];
}

class EstadosCivilesInitial extends EstadoCivilState {}

class EstadosCivilesLoading extends EstadoCivilState {}

class EstadosCivilesLoaded extends EstadoCivilState {
  final List<EstadoCivilEntity>? estadosCivilesLoaded;

  const EstadosCivilesLoaded(this.estadosCivilesLoaded)
      : super(estadosCiviles: estadosCivilesLoaded);
}

class EstadosCivilesError extends EstadoCivilState {
  final String message;

  const EstadosCivilesError(this.message);

  @override
  List<Object?> get props => [message];
}
