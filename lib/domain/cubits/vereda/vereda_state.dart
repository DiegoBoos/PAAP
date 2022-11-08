part of 'vereda_cubit.dart';

abstract class VeredaState extends Equatable {
  final List<VeredaEntity>? veredas;
  const VeredaState({this.veredas});

  @override
  List<Object?> get props => [veredas];
}

class VeredasInitial extends VeredaState {}

class VeredasLoading extends VeredaState {}

class VeredasLoaded extends VeredaState {
  final List<VeredaEntity>? veredasLoaded;

  const VeredasLoaded(this.veredasLoaded) : super(veredas: veredasLoaded);
}

class VeredasError extends VeredaState {
  final String message;

  const VeredasError(this.message);

  @override
  List<Object?> get props => [message];
}
