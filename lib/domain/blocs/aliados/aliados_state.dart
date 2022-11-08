part of 'aliados_bloc.dart';

abstract class AliadosState extends Equatable {
  const AliadosState();

  @override
  List<Object> get props => [];
}

class AliadosInitial extends AliadosState {}

class AliadosLoading extends AliadosState {}

class AliadosLoaded extends AliadosState {
  final List<AliadoEntity>? aliadosLoaded;

  const AliadosLoaded({this.aliadosLoaded});
}

class AliadosError extends AliadosState {
  final String message;

  const AliadosError(this.message);
}
