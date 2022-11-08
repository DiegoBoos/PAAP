part of 'aliados_bloc.dart';

abstract class AliadosEvent extends Equatable {
  const AliadosEvent();

  @override
  List<Object> get props => [];
}

class GetAliados extends AliadosEvent {}
