part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class VerifyAuth extends AuthEvent {}

class LogIn extends AuthEvent {
  final UsuarioEntity usuario;
  final String token;
  const LogIn(this.usuario, this.token);

  @override
  List<Object?> get props => [usuario, token];
}

class LogOut extends AuthEvent {}
