import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/usuario_entity.dart';
import '../../usecases/auth/auth_db_usecase.dart';
import '../../usecases/auth/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase auth;
  final AuthUsecaseDB authDB;

  AuthBloc({
    required this.auth,
    required this.authDB,
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

    on<SaveUsuario>((event, emit) async {
      await _saveUsuario(event.usuario, emit);
    });
  }

  _logIn(event, emit) async {
    final usuario = event.usuario;

    final result = await auth.verificacionUsecase(usuario);
    result.fold((failure) {
      emit(AuthError(failure.properties.first));
    }, (data) async {
      emit(AuthLoaded(data));
    });
  }

  _logInDB(event, emit) async {
    final verificacionDatosLocalesDB = await _verificacionDatosLocalesDB();
    if (verificacionDatosLocalesDB == '') {
      final usuario = event.usuario;

      final result = await authDB.verificacionUsecaseDB(usuario);
      result.fold((failure) {
        emit(AuthError(failure.properties.first));
      }, (data) {
        if (data == null) {
          emit(const AuthError('Usuario no autenticado'));
        }

        emit(AuthLoaded(data));
      });
    } else {
      emit(AuthError(verificacionDatosLocalesDB));
    }
  }

  Future<String> _verificacionDatosLocalesDB() async {
    final result = await authDB.verificacionDatosLocalesUsecaseDB();
    return result.fold((failure) {
      return failure.properties.first.toString();
    }, (data) {
      if (data == 0) {
        return 'No existe usuario. Inicie sesión con conexión a internet';
      }
      return '';
    });
  }

  _saveUsuario(UsuarioEntity usuario, emit) async {
    final result = await authDB.saveUsuarioUsecase(usuario);
    result.fold((failure) {
      emit(AuthError(failure.properties.first));
    }, (_) {});
  }
}
