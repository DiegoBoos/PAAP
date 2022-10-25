part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LogIn extends AuthEvent {
  final UsuarioEntity usuario;
  final bool isOffline;

  const LogIn({required this.usuario, this.isOffline = false});
}

class LogOut extends AuthEvent {}
