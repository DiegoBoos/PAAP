part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  final bool isLoggedIn;
  final UsuarioEntity? usuario;

  const AuthState({this.isLoggedIn = false, this.usuario});

  @override
  List<Object?> get props => [isLoggedIn, usuario];
}

class AuthInitialState extends AuthState {
  const AuthInitialState() : super(isLoggedIn: false, usuario: null);
}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final UsuarioEntity? usuarioAutenticado;

  const AuthLoaded(this.usuarioAutenticado)
      : super(isLoggedIn: true, usuario: usuarioAutenticado);

  @override
  List<Object?> get props => [usuarioAutenticado, isLoggedIn];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
