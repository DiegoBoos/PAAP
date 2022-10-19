import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paap/domain/cubits/internet/internet_cubit.dart';
import 'package:paap/domain/entities/menu_entity.dart';
import 'package:paap/domain/usecases/verificacion.dart';
import 'package:paap/domain/usecases/verificacion_db.dart';
import '../../entities/usuario_entity.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final InternetCubit internetCubit;

  final Verificacion verificacion;
  final VerificacionDB verificacionDB;

  AuthBloc({
    required this.internetCubit,
    required this.verificacion,
    required this.verificacionDB,
  }) : super(const AuthInitial()) {
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
      emit(const AuthInitial());
    });
  }

  _logInOnline(event, emit) async {
    final usuarioId = event.usuarioId;
    final contrasena = event.contrasena;

    final result = await verificacion.verificacion(usuarioId!, contrasena!);
    result.fold((failure) {
      emit(AuthError(failure.properties.first));
    }, (data) {
      emit(AuthLoaded(true, data));
      guardarUsuario(data, emit);
    });
  }

  _logInOffline(event, emit) async {
    final usuarioId = event.usuarioId;
    final contrasena = event.contrasena;

    final result = await verificacionDB.verificacionDB(usuarioId, contrasena);
    result.fold((failure) {
      emit(AuthError(failure.properties.first));
    }, (data) async {
      final usuarioMap = {for (var e in data[0].entries) e.key: e.value};
      final usuarioAutenticado = UsuarioEntity.fromJson(usuarioMap);
      emit(AuthLoaded(true, usuarioAutenticado));
    });
  }

  guardarUsuario(UsuarioEntity data, emit) async {
    final result = await verificacionDB.guardarUsuarioDB(data);
    result.fold((failure) {
      emit(AuthError(failure.properties.first));
    }, (_) {});
  }
}
