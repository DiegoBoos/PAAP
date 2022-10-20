import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paap/domain/cubits/internet/internet_cubit.dart';
import 'package:paap/domain/usecases/auth/verificacion_usecase.dart';
import 'package:paap/domain/usecases/auth/verificacion_db_usecase.dart';
import '../../entities/usuario_entity.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final InternetCubit internetCubit;

  final VerificacionUsecase verificacion;
  final VerificacionUsecaseDB verificacionDB;

  AuthBloc({
    required this.internetCubit,
    required this.verificacion,
    required this.verificacionDB,
  }) : super(AuthInitial()) {
    on<LogIn>((event, emit) async {
      if (event.isOffline) {
        emit(AuthLoading());
        await _logInOffline(event, emit);
      } else {
        emit(AuthLoading());
        await _logInOnline(event, emit);
      }
    });

    on<LogOut>((_, emit) async {
      emit(AuthInitial());
    });
  }

  _logInOnline(event, emit) async {
    final usuarioId = event.usuarioId;
    final contrasena = event.contrasena;

    final result =
        await verificacion.verificacionUsecase(usuarioId!, contrasena!);
    result.fold((failure) {
      emit(AuthError(failure.properties.first));
    }, (data) {
      emit(AuthLoaded(data));
      saveUsuario(data, emit);
    });
  }

  _logInOffline(event, emit) async {
    final usuarioId = event.usuarioId;
    final contrasena = event.contrasena;

    final result =
        await verificacionDB.verificacionUsecaseDB(usuarioId, contrasena);
    result.fold((failure) {
      emit(AuthError(failure.properties.first));
    }, (data) {
      if (data == null) return emit(const AuthError('Usuario no autenticado'));

      emit(AuthLoaded(data));
    });
  }

  saveUsuario(UsuarioEntity data, emit) async {
    final result = await verificacionDB.saveUsuarioUsecaseDB(data);
    result.fold((failure) {
      emit(AuthError(failure.properties.first));
    }, (_) {});
  }
}
