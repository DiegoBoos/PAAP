import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_consultor_entity.dart';
import '../../usecases/perfil_preinversion_consultor/perfil_preinversion_consultor_db_usecase.dart';

part '../perfil_preinversion_consultores/perfil_preinversion_consultores_event.dart';
part '../perfil_preinversion_consultores/perfil_preinversion_consultores_state.dart';

class PerfilPreInversionConsultoresBloc extends Bloc<
    PerfilPreInversionConsultoresEvent, PerfilPreInversionConsultoresState> {
  final PerfilPreInversionConsultorUsecaseDB perfilPreInversionConsultoresDB;

  PerfilPreInversionConsultoresBloc({
    required this.perfilPreInversionConsultoresDB,
  }) : super(PerfilPreInversionConsultoresInitial()) {
    on<GetPerfilPreInversionConsultores>((event, emit) async {
      emit(PerfilPreInversionConsultoresLoading());
      await _getPerfilPreInversionConsultores(event, emit);
    });
  }

  _getPerfilPreInversionConsultores(event, emit) async {
    final result = await perfilPreInversionConsultoresDB
        .getPerfilPreInversionConsultoresUsecaseDB();
    result.fold(
        (failure) =>
            emit(PerfilPreInversionConsultoresError(failure.properties.first)),
        (data) => emit(PerfilPreInversionConsultoresLoaded(
            perfilPreInversionConsultoresLoaded: data)));
  }
}
