part of 'grupo_especial_cubit.dart';

abstract class GrupoEspecialState extends Equatable {
  final List<GrupoEspecialEntity>? gruposEspeciales;
  const GrupoEspecialState({this.gruposEspeciales});

  @override
  List<Object?> get props => [gruposEspeciales];
}

class GruposEspecialesInitial extends GrupoEspecialState {}

class GruposEspecialesLoading extends GrupoEspecialState {}

class GruposEspecialesLoaded extends GrupoEspecialState {
  final List<GrupoEspecialEntity>? gruposEspecialesLoaded;

  const GruposEspecialesLoaded(this.gruposEspecialesLoaded)
      : super(gruposEspeciales: gruposEspecialesLoaded);
}

class GruposEspecialesError extends GrupoEspecialState {
  final String message;

  const GruposEspecialesError(this.message);

  @override
  List<Object?> get props => [message];
}
