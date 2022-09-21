import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:paap/data/models/usuario_model.dart';
import 'package:paap/domain/entities/usuario.dart';

import '../../../data/datasources/local/secure_storage.dart';
import '../../usecases/get_perfiles.dart';
import '../../usecases/get_usuario.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthEmpty()) {
    on<VerifyAuth>((event, emit) async {
      emit(AuthLoading());

      final token = await SecureStorage.readToken();
      final usuario = await SecureStorage.getUsuario();

      if (token.isEmpty && usuario == null) {
        const AuthError('No se pudo obtener la información del storage');
        return;
      }

      emit(AuthHasData(usuario!, token));
    });

    on<LogIn>((event, emit) async {
      final usuario = event.usuario;
      final token = event.token;

      emit(AuthLoading());

      final result = await GetUsuario.execute();

      result.fold((failure) {
        emit(AuthError(failure.message));
      }, (data) async {
        emit(AuthHasData(data, token));
      });
    });

    on<LogOut>((_, emit) async {
      await SecureStorage.storage.deleteAll();
      emit(const AuthEmpty());
    });
  }
}
