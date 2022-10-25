import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paap/domain/entities/perfil_entity.dart';
import 'package:paap/domain/entities/perfiles_entity.dart';
import 'package:paap/domain/entities/usuario_entity.dart';

import '../../cubits/internet/internet_cubit.dart';

import '../../usecases/perfiles/perfiles_db_usecase.dart';
import '../../usecases/perfiles/perfiles_usecase.dart';

part 'perfiles_event.dart';
part 'perfiles_state.dart';

class PerfilesBloc extends Bloc<PerfilesEvent, PerfilesState> {
  final InternetCubit internetCubit;

  final PerfilesUsecase perfiles;
  final PerfilesUsecaseDB perfilesDB;

  PerfilesBloc({
    required this.internetCubit,
    required this.perfiles,
    required this.perfilesDB,
  }) : super(PerfilesInitial()) {
    on<GetPerfiles>((event, emit) async {
      if (event.isOffline) {
        emit(PerfilesLoading());
        await _getPerfilesOffline(event, emit);
      } else {
        emit(PerfilesLoading());
        await _getPerfilesOnline(event, emit);
      }
    });

    on<GetPerfilesFiltros>((event, emit) async {
      if (event.isOffline) {
        emit(PerfilesLoading());
        await _getPerfilesFiltrosOffline(event, emit);
      } else {
        emit(PerfilesLoading());
        await _getPerfilesFiltrosOnline(event, emit);
      }
    });

    on<GetPerfil>((event, emit) async {
      if (event.isOffline) {
        emit(PerfilLoading());
        //await _getPerfilOffline(event, emit);
      } else {
        emit(PerfilLoading());
        await _getPerfilOnline(event, emit);
      }
    });
  }

  _getPerfilesOnline(event, emit) async {
    final usuario = event.usuario;

    final result = await perfiles.getPerfilesUsecase(usuario);
    result.fold((failure) {
      emit(PerfilesError(failure.properties.first));
    }, (data) async {
      emit(PerfilesLoaded(perfilesLoaded: data));
      await perfilesDB.savePerfilesDB(data);
    });
  }

  _getPerfilesOffline(event, emit) async {
    final result = await perfilesDB.getPerfilesUsecaseDB();
    result.fold((failure) {
      emit(PerfilesError(failure.properties.first));
    }, (data) {
      emit(PerfilesLoaded(perfilesLoaded: data));
    });
  }

  _getPerfilesFiltrosOnline(event, emit) async {
    final usuario = event.usuario;
    final id = event.id;
    final nombre = event.nombre;

    final result =
        await perfiles.getPerfilesFiltrosUsecase(usuario, id, nombre);
    result.fold((failure) {
      emit(PerfilesError(failure.properties.first));
    }, (data) async {
      emit(PerfilesLoaded(perfilesLoaded: data));
      /* await perfilesDB.savePerfilesDB(data); */
    });
  }

  _getPerfilesFiltrosOffline(event, emit) async {
    final id = event.id;
    final nombre = event.nombre;

    final result = await perfilesDB.getPerfilesFiltrosUsecaseDB(id, nombre);
    result.fold((failure) {
      emit(PerfilesError(failure.properties.first));
    }, (data) {
      emit(PerfilesLoaded(perfilesLoaded: data));
    });
  }

  _getPerfilOnline(event, emit) async {
    final usuario = event.usuario;
    final perfilId = event.perfilId;

    final result = await perfiles.getPerfilUsecase(usuario, perfilId);
    result.fold((failure) {
      emit(PerfilError(failure.properties.first));
    }, (data) {
      emit(PerfilLoaded(perfilLoaded: data));
    });
  }
}
