import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../cubits/internet/internet_cubit.dart';

import '../../entities/perfil_entity.dart';
import '../../entities/usuario_entity.dart';
import '../../entities/vperfil_entity.dart';
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
    on<GetPerfilesFiltros>((event, emit) async {
      emit(PerfilesLoading());
      await _getPerfilesFiltros(event, emit);
    });

    on<GetPerfil>((event, emit) async {
      emit(PerfilLoading());
      await _getPerfil(event, emit);
    });
  }

  _getPerfilesFiltros(event, emit) async {
    final id = event.id;
    final nombre = event.nombre;

    final result = await perfilesDB.getPerfilesFiltrosUsecaseDB(id, nombre);
    result.fold((failure) {
      emit(PerfilesError(failure.properties.first));
    }, (data) {
      emit(PerfilesLoaded(perfilesLoaded: data));
    });
  }

  _getPerfil(event, emit) async {
    final perfilId = event.perfilId;

    final result = await perfilesDB.getPerfilUsecaseDB(perfilId);
    result.fold((failure) {
      emit(PerfilError(failure.properties.first));
    }, (data) {
      //emit(PerfilLoaded(perfilLoaded: data));
    });
  }
}
