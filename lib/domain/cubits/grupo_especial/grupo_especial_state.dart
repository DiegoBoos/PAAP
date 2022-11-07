part of 'grupo_especial_cubit.dart';

abstract class GrupoEspecialState extends Equatable {
  final List<GrupoEspecialEntity>? grupoEspecial;
  const GrupoEspecialState({this.grupoEspecial});

  @override
  List<Object?> get props => [grupoEspecial];
}

class GrupoEspecialInitial extends GrupoEspecialState {}

class GrupoEspecialLoading extends GrupoEspecialState {}

class GrupoEspecialLoaded extends GrupoEspecialState {
  final List<GrupoEspecialEntity>? grupoEspecialLoaded;

  const GrupoEspecialLoaded(this.grupoEspecialLoaded)
      : super(grupoEspecial: grupoEspecialLoaded);
}

class GrupoEspecialError extends GrupoEspecialState {
  final String message;

  const GrupoEspecialError(this.message);

  @override
  List<Object?> get props => [message];
}
