part of 'alianza_cubit.dart';

abstract class AlianzaState extends Equatable {
  final VAlianzaEntity? alianza;
  const AlianzaState({this.alianza});

  @override
  List<Object?> get props => [alianza];
}

class AlianzaInitial extends AlianzaState {}

class AlianzaLoading extends AlianzaState {}

class AlianzaLoaded extends AlianzaState {
  final VAlianzaEntity? alianzaLoaded;

  const AlianzaLoaded(this.alianzaLoaded) : super(alianza: alianzaLoaded);
}

class AlianzaError extends AlianzaState {
  final String message;

  const AlianzaError(this.message);

  @override
  List<Object?> get props => [message];
}
