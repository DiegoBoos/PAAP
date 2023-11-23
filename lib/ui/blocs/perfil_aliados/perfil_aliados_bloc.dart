import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/perfil_aliado_entity.dart';
import '../../../domain/usecases/perfil_aliado/perfil_aliado_db_usecase.dart';

part 'perfil_aliados_event.dart';
part 'perfil_aliados_state.dart';

class PerfilAliadosBloc extends Bloc<PerfilAliadosEvent, PerfilAliadosState> {
  final PerfilAliadoUsecaseDB perfilAliadoUsecaseDB;
  PerfilAliadosBloc({required this.perfilAliadoUsecaseDB})
      : super(PerfilAliadosInitial()) {
    on(<InitState>(event, emit) async {
      emit(PerfilAliadosInitial());
    });

    on<GetPerfilAliados>((event, emit) async {
      emit(PerfilAliadosLoading());
      await _getPerfilAliados(event, emit);
    });
  }

  _getPerfilAliados(event, emit) async {
    final result =
        await perfilAliadoUsecaseDB.getPerfilAliadosUsecaseDB(event.perfilId);
    result.fold((failure) => emit(PerfilAliadosError(failure.properties.first)),
        (data) => emit(PerfilAliadosLoaded(data)));
  }
}
