part of 'perfil_aliados_bloc.dart';

abstract class PerfilAliadosEvent extends Equatable {
  const PerfilAliadosEvent();

  @override
  List<Object> get props => [];
}

class InitState extends PerfilAliadosEvent {}

class GetPerfilAliados extends PerfilAliadosEvent {
  final String perfilId;

  const GetPerfilAliados(this.perfilId);
}
