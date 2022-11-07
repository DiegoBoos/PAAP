part of 'aliado_cubit.dart';

abstract class AliadoState extends Equatable {
  final List<AliadoEntity>? aliado;
  const AliadoState({this.aliado});

  @override
  List<Object?> get props => [aliado];
}

class AliadoInitial extends AliadoState {}

class AliadoLoading extends AliadoState {}

class AliadoLoaded extends AliadoState {
  final List<AliadoEntity>? aliadoLoaded;

  const AliadoLoaded(this.aliadoLoaded) : super(aliado: aliadoLoaded);
}

class AliadoError extends AliadoState {
  final String message;

  const AliadoError(this.message);

  @override
  List<Object?> get props => [message];
}
