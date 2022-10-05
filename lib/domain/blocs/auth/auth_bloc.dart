import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:paap/domain/blocs/internet/internet_cubit.dart';
import 'package:paap/domain/usecases/verificar_usuario.dart';
import '../../entities/usuario.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final VerificarUsuario verificarUsuario;

  AuthBloc({required this.verificarUsuario}) : super(const AuthInitialState()) {
    on<LogIn>((event, emit) async {
      final usuarioId = event.usuarioId;
      final contrasena = event.contrasena;
      final isOffline = event.isOffline;

      emit(AuthLoading());

      if (!isOffline) {
        final result = await verificarUsuario.execute(usuarioId, contrasena);
        result.fold((failure) {
          emit(AuthError(failure.properties.first));
        }, (data) {
          emit(AuthLoaded(data));
        });
      } else {
        print('Connect to DB');
      }
    });

    on<LogOut>((_, emit) async {
      emit(const AuthInitialState());
    });
  }
}
