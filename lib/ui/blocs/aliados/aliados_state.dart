part of 'aliados_bloc.dart';

abstract class AliadosState extends Equatable {
  final List<AliadoEntity>? aliados;

  const AliadosState({this.aliados});

  @override
  List<Object> get props => [];
}

class AliadosInitial extends AliadosState {
  AliadosInitial() : super(aliados: []);
}

class AliadosLoading extends AliadosState {}

class AliadosLoaded extends AliadosState {
  final List<AliadoEntity> aliadosLoaded;

  const AliadosLoaded(this.aliadosLoaded) : super(aliados: aliadosLoaded);
}

class AliadosError extends AliadosState {
  final String message;

  AliadosError(this.message) : super(aliados: []);
}
