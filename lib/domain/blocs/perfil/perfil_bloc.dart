import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../entities/perfil.dart';

part 'perfil_event.dart';
part 'perfil_state.dart';

class PerfilBloc extends Bloc<PerfilEvent, PerfilState> {
  PerfilBloc() : super(const PerfilInitialState()) {
    on<PerfilChanged>((event, emit) => emit(PerfilSetState(event.profile)));
  }
}
