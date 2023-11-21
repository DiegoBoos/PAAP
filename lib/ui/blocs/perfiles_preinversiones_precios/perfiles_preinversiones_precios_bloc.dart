import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/perfil_preinversion_precio_entity.dart';
import '../../../domain/usecases/perfil_preinversion_precio/perfil_preinversion_precio_db_usecase.dart';

part 'perfiles_preinversiones_precios_event.dart';
part 'perfiles_preinversiones_precios_state.dart';

class PerfilesPreInversionesPreciosBloc extends Bloc<
    PerfilesPreInversionesPreciosEvent, PerfilesPreInversionesPreciosState> {
  final PerfilPreInversionPrecioUsecaseDB perfilPreInversionPrecioUsecaseDB;
  PerfilesPreInversionesPreciosBloc(
      {required this.perfilPreInversionPrecioUsecaseDB})
      : super(PerfilesPreInversionesPreciosInitial()) {
    on<GetPerfilesPreInversionesPrecios>((event, emit) async {
      emit(PerfilesPreInversionesPreciosLoading());
      await _getPerfilesPreInversionesPrecios(event, emit);
    });
  }
  _getPerfilesPreInversionesPrecios(event, emit) async {
    final result = await perfilPreInversionPrecioUsecaseDB
        .getPerfilesPreInversionesPreciosUsecaseDB(event.perfilPreInversionId);
    result.fold(
        (failure) =>
            emit(PerfilesPreInversionesPreciosError(failure.properties.first)),
        (data) => emit(PerfilesPreInversionesPreciosLoaded(data)));
  }
}
