import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_entity.dart';
import '../../usecases/perfiles/perfiles_db_usecase.dart';

part 'perfiles_event.dart';
part 'perfiles_state.dart';

class PerfilesBloc extends Bloc<PerfilesEvent, PerfilesState> {
  final PerfilesUsecaseDB perfilesDB;

  PerfilesBloc({
    required this.perfilesDB,
  }) : super(PerfilesInitial()) {
    on<GetPerfiles>((event, emit) async {
      emit(PerfilesLoading());
      await _getPerfiles(event, emit);
    });

    on<GetPerfilesFiltros>((event, emit) async {
      emit(PerfilesLoading());
      await _getPerfilesFiltros(event, emit);
    });
  }

  _getPerfiles(event, emit) async {
    final result = await perfilesDB.getPerfilesUsecaseDB();
    result.fold((failure) => emit(PerfilesError(failure.properties.first)),
        (data) => emit(PerfilesLoaded(perfilesLoaded: data)));
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
}
