part of 'v_alianza_cubit.dart';

abstract class VAlianzaState extends Equatable {
  final VAlianzaEntity? vAlianza;

  const VAlianzaState({this.vAlianza});

  @override
  List<Object?> get props => [vAlianza];
}

class VAlianzaInitial extends VAlianzaState {}

class VAlianzaSelected extends VAlianzaState {
  final VAlianzaEntity? vAlianzaSelected;

  const VAlianzaSelected(this.vAlianzaSelected)
      : super(vAlianza: vAlianzaSelected);
}

class VAlianzaError extends VAlianzaState {
  final String message;

  const VAlianzaError(this.message);
  @override
  List<Object?> get props => [message];
}
