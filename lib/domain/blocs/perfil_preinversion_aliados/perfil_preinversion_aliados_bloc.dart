import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_aliado_entity.dart';
import '../../usecases/perfil_preinversion_aliado/perfil_preinversion_aliado_db_usecase.dart';

part 'perfil_preinversion_aliados_event.dart';
part 'perfil_preinversion_aliados_state.dart';

class PerfilPreInversionAliadosBloc extends Bloc<PerfilPreInversionAliadosEvent,
    PerfilPreInversionAliadosState> {
  final PerfilPreInversionAliadoUsecaseDB perfilPreInversionAliadosDB;

  PerfilPreInversionAliadosBloc({
    required this.perfilPreInversionAliadosDB,
  }) : super(PerfilPreInversionAliadosInitial()) {
    on<GetPerfilPreInversionAliados>((event, emit) async {
      emit(PerfilPreInversionAliadosLoading());
      await _getPerfilPreInversionAliados(event, emit);
    });
  }

  _getPerfilPreInversionAliados(event, emit) async {
    final result = await perfilPreInversionAliadosDB
        .getPerfilPreInversionAliadosUsecaseDB();
    result.fold(
        (failure) =>
            emit(PerfilPreInversionAliadosError(failure.properties.first)),
        (data) => emit(PerfilPreInversionAliadosLoaded(
            perfilPreInversionAliadosLoaded: data)));
  }
}
