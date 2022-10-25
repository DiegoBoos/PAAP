import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:paap/domain/usecases/auth/verificacion_usecase.dart';
import 'package:paap/domain/usecases/auth/verificacion_db_usecase.dart';
import '../../entities/usuario_entity.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final VerificacionUsecase verificacion;
  final VerificacionUsecaseDB verificacionDB;

  AuthBloc({
    required this.verificacion,
    required this.verificacionDB,
  }) : super(AuthInitial()) {
    on<LogIn>((event, emit) async {
      if (event.isOffline) {
        emit(AuthLoading());
        await _logInDB(event, emit);
      } else {
        emit(AuthLoading());
        await _logIn(event, emit);
      }
    });

    on<LogOut>((_, emit) async {
      emit(AuthInitial());
    });
  }

  _logIn(event, emit) async {
    final usuario = event.usuario;

    final result = await verificacion.verificacionUsecase(usuario);
    result.fold((failure) {
      emit(AuthError(failure.properties.first));
    }, (data) async {
      emit(AuthLoaded(data));
      await _saveUsuario(data, emit);
    });
  }

  _logInDB(event, emit) async {
    final usuario = event.usuario;

    final result = await verificacionDB.verificacionUsecaseDB(usuario);
    result.fold((failure) {
      emit(AuthError(failure.properties.first));
    }, (data) {
      if (data == null) return emit(const AuthError('Usuario no autenticado'));

      emit(AuthLoaded(data));
    });
  }

  _saveUsuario(UsuarioEntity data, emit) async {
    final result = await verificacionDB.saveUsuarioUsecaseDB(data);
    result.fold((failure) {
      emit(AuthError(failure.properties.first));
    }, (_) {});
  }
}
