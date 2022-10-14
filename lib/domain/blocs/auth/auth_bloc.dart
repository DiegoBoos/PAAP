import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paap/domain/entities/menu_entity.dart';
import 'package:paap/domain/usecases/verificacion.dart';
import 'package:paap/domain/usecases/verificacion_db.dart';
import '../../entities/usuario_entity.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Verificacion verificacion;
  final VerificacionDB verificacionDB;

  AuthBloc({
    required this.verificacion,
    required this.verificacionDB,
  }) : super(const AuthInitial()) {
    on<ExisteUsuarioDB>((event, emit) async {
      emit(AuthLoading());

      final result = await verificacionDB.existeUsuarioDB();
      result.fold((failure) {
        emit(AuthError(failure.properties.first));
      }, (data) {
        final usuarioMap = {for (var e in data[0].entries) e.key: e.value};
        final usuarioAutenticado = UsuarioEntity.fromJson(usuarioMap);
        emit(AuthLoaded(true, usuarioAutenticado));
      });
    });

    on<LogIn>((event, emit) async {
      final usuarioId = event.usuarioId;
      final contrasena = event.contrasena;
      final isOffline = event.isOffline;

      emit(AuthLoading());

      if (!isOffline) {
        final result = await verificacion.verificacion(usuarioId, contrasena);
        result.fold((failure) {
          emit(AuthError(failure.properties.first));
        }, (data) async {
          emit(AuthLoaded(true, data));
          guardarUsuario(emit, data);
        });
      } else {
        final result =
            await verificacionDB.verificacionDB(usuarioId, contrasena);
        result.fold((failure) {
          emit(AuthError(failure.properties.first));
        }, (data) {
          print(data);
        });
      }
    });

    on<LogOut>((_, emit) async {
      emit(const AuthInitial());
    });
  }

  Future<void> guardarUsuario(
      Emitter<AuthState> emit, UsuarioEntity data) async {
    final result = await verificacionDB.guardarUsuarioDB(data);
    result.fold((failure) {
      emit(AuthError(failure.properties.first));
    }, (_) {});
  }
}
