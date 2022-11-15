import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/v_perfil_preinversion_entity.dart';
import '../../usecases/perfil_preinversion/perfil_preinversion_db_usecase.dart';

part 'perfiles_preinversion_event.dart';
part 'perfiles_preinversion_state.dart';

class PerfilesPreInversionBloc
    extends Bloc<PerfilesPreInversionEvent, PerfilesPreInversionState> {
  final PerfilPreInversionUsecaseDB perfilesPreInversionDB;

  PerfilesPreInversionBloc({
    required this.perfilesPreInversionDB,
  }) : super(PerfilesPreInversionInitial()) {
    on<GetPerfilesPreInversion>((event, emit) async {
      emit(PerfilesPreInversionLoading());
      await _getPerfilesPreInversion(event, emit);
    });

    on<GetPerfilesPreInversionFiltros>((event, emit) async {
      emit(PerfilesPreInversionLoading());
      await _getPerfilesPreInversionFiltros(event, emit);
    });
  }

  _getPerfilesPreInversion(event, emit) async {
    final result =
        await perfilesPreInversionDB.getPerfilesPreInversionUsecaseDB();
    result.fold(
        (failure) => emit(PerfilesPreInversionError(failure.properties.first)),
        (data) =>
            emit(PerfilesPreInversionLoaded(perfilesPreInversionLoaded: data)));
  }

  _getPerfilesPreInversionFiltros(event, emit) async {
    final id = event.id;
    final nombre = event.nombre;

    final result = await perfilesPreInversionDB
        .getPerfilesPreInversionFiltrosUsecaseDB(id, nombre);
    result.fold((failure) {
      emit(PerfilesPreInversionError(failure.properties.first));
    }, (data) {
      emit(PerfilesPreInversionLoaded(perfilesPreInversionLoaded: data));
    });
  }
}
