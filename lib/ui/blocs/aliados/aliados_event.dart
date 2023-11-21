part of 'aliados_bloc.dart';

abstract class AliadosEvent extends Equatable {
  const AliadosEvent();

  @override
  List<Object> get props => [];
}

class InitState extends AliadosEvent {}

class GetAliados extends AliadosEvent {
  final String perfilId;

  const GetAliados(this.perfilId);
}
