part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  final bool isLoggedIn;
  final UsuarioEntity? usuario;
  final String token;

  const AuthState({this.isLoggedIn = false, this.usuario, this.token = ''});

  @override
  List<Object?> get props => [isLoggedIn, usuario, token];
}

class AuthEmpty extends AuthState {
  const AuthEmpty() : super(isLoggedIn: false, usuario: null, token: '');
}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthHasData extends AuthState {
  final UsuarioEntity result;
  final String newToken;

  const AuthHasData(this.result, this.newToken)
      : super(isLoggedIn: true, usuario: result, token: newToken);

  @override
  List<Object?> get props => [result, newToken, isLoggedIn];
}
