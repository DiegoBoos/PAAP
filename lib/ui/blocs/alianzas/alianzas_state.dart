part of 'alianzas_bloc.dart';

abstract class AlianzasState extends Equatable {
  const AlianzasState();

  @override
  List<Object> get props => [];
}

class AlianzasInitial extends AlianzasState {}

class AlianzasLoading extends AlianzasState {}

class AlianzasLoaded extends AlianzasState {
  final List<VAlianzaEntity>? alianzasLoaded;

  const AlianzasLoaded({this.alianzasLoaded});
}

class AlianzasError extends AlianzasState {
  final String message;

  const AlianzasError(this.message);
}
