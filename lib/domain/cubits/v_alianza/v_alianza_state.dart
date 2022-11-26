part of 'v_alianza_cubit.dart';

abstract class VAlianzaState extends Equatable {
  final VAlianzaEntity? vPerfilPreInversion;

  const VAlianzaState({this.vPerfilPreInversion});

  @override
  List<Object?> get props => [vPerfilPreInversion];
}

class VAlianzaInitial extends VAlianzaState {}

class VAlianzaSelected extends VAlianzaState {
  final VAlianzaEntity? vPerfilPreInversionSelected;

  const VAlianzaSelected(this.vPerfilPreInversionSelected)
      : super(vPerfilPreInversion: vPerfilPreInversionSelected);
}

class VAlianzaError extends VAlianzaState {
  final String message;

  const VAlianzaError(this.message);
  @override
  List<Object?> get props => [message];
}
