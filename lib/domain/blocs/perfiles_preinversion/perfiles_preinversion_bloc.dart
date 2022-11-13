import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/v_perfil_preinversion_entity.dart';
import '../../usecases/perfil_preinversion/perfil_preinversion_db_usecase.dart';

part 'perfiles_preinversion_event.dart';
part 'perfiles_preinversion_state.dart';

class PerfilesPreinversionBloc
    extends Bloc<PerfilesPreinversionEvent, PerfilesPreinversionState> {
  final PerfilPreinversionUsecaseDB perfilesPreinversionDB;

  PerfilesPreinversionBloc({
    required this.perfilesPreinversionDB,
  }) : super(PerfilesPreinversionInitial()) {
    on<GetPerfilesPreinversion>((event, emit) async {
      emit(PerfilesPreinversionLoading());
      await _getPerfilesPreinversion(event, emit);
    });

    on<GetPerfilesPreinversionFiltros>((event, emit) async {
      emit(PerfilesPreinversionLoading());
      await _getPerfilesPreinversionFiltros(event, emit);
    });
  }

  _getPerfilesPreinversion(event, emit) async {
    final result =
        await perfilesPreinversionDB.getPerfilesPreinversionUsecaseDB();
    result.fold(
        (failure) => emit(PerfilesPreinversionError(failure.properties.first)),
        (data) =>
            emit(PerfilesPreinversionLoaded(perfilesPreinversionLoaded: data)));
  }

  _getPerfilesPreinversionFiltros(event, emit) async {
    final id = event.id;
    final nombre = event.nombre;

    final result = await perfilesPreinversionDB
        .getPerfilesPreinversionFiltrosUsecaseDB(id, nombre);
    result.fold((failure) {
      emit(PerfilesPreinversionError(failure.properties.first));
    }, (data) {
      emit(PerfilesPreinversionLoaded(perfilesPreinversionLoaded: data));
    });
  }
}
