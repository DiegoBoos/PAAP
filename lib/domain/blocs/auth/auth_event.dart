part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LogIn extends AuthEvent {
  final String usuarioId;
  final String contrasena;
  final bool isOffline;

  const LogIn(
      {required this.usuarioId,
      required this.contrasena,
      this.isOffline = false});
}

class LogOut extends AuthEvent {}

class ExisteUsuarioDB extends AuthEvent {}
