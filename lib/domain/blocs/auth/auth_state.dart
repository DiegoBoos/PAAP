part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final bool isLoggedIn;
  final bool isChecking;
  final UsuarioEntity? usuario;
  final List<MenuEntity>? menu;

  const AuthState(
      {this.isLoggedIn = false,
      this.isChecking = false,
      this.usuario,
      this.menu});

  @override
  List<Object?> get props => [isLoggedIn, usuario];
}

class AuthInitial extends AuthState {
  const AuthInitial() : super(isLoggedIn: false, usuario: null);
}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final UsuarioEntity? usuarioAutenticado;
  final bool wasChecked;

  const AuthLoaded(this.wasChecked, this.usuarioAutenticado)
      : super(
          isLoggedIn: true,
          isChecking: wasChecked,
          usuario: usuarioAutenticado,
        );

  @override
  List<Object?> get props => [usuarioAutenticado, isLoggedIn];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
