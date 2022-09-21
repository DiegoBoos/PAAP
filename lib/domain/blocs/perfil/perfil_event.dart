part of 'perfil_bloc.dart';

@immutable
abstract class PerfilEvent {}

class PerfilChanged extends PerfilEvent {
  final PerfilEntity profile;
  PerfilChanged(this.profile);
}
