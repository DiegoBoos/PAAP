part of 'perfil_bloc.dart';

@immutable
abstract class PerfilState extends Equatable {
  final PerfilEntity? profile;

  const PerfilState({this.profile});

  @override
  List<Object> get props => [];
}

class PerfilInitialState extends PerfilState {
  const PerfilInitialState() : super(profile: null);
}

class PerfilSetState extends PerfilState {
  final PerfilEntity newPerfil;

  const PerfilSetState(this.newPerfil) : super(profile: newPerfil);
}
