part of 'perfil_aliados_bloc.dart';

abstract class PerfilAliadosState extends Equatable {
  final List<PerfilAliadoEntity>? perfilAliados;

  const PerfilAliadosState({this.perfilAliados});

  @override
  List<Object> get props => [];
}

class PerfilAliadosInitial extends PerfilAliadosState {
  PerfilAliadosInitial() : super(perfilAliados: []);
}

class PerfilAliadosLoading extends PerfilAliadosState {}

class PerfilAliadosLoaded extends PerfilAliadosState {
  final List<PerfilAliadoEntity> perfilAliadosLoaded;

  const PerfilAliadosLoaded(this.perfilAliadosLoaded)
      : super(perfilAliados: perfilAliadosLoaded);
}

class PerfilAliadosError extends PerfilAliadosState {
  final String message;

  PerfilAliadosError(this.message) : super(perfilAliados: []);
}
