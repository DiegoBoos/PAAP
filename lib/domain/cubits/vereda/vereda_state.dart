part of 'vereda_cubit.dart';

abstract class VeredaState extends Equatable {
  final List<VeredaEntity>? vereda;
  const VeredaState({this.vereda});

  @override
  List<Object?> get props => [vereda];
}

class VeredaInitial extends VeredaState {}

class VeredaLoading extends VeredaState {}

class VeredaLoaded extends VeredaState {
  final List<VeredaEntity>? veredaLoaded;

  const VeredaLoaded(this.veredaLoaded) : super(vereda: veredaLoaded);
}

class VeredaError extends VeredaState {
  final String message;

  const VeredaError(this.message);

  @override
  List<Object?> get props => [message];
}
