import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_cofinanciador_rubro_entity.dart';
import '../../usecases/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_db_usecase.dart';

part 'perfil_preinversion_cofinanciador_rubros_event.dart';
part 'perfil_preinversion_cofinanciador_rubros_state.dart';

class PerfilPreInversionCofinanciadorRubrosBloc extends Bloc<
    PerfilPreInversionCofinanciadorRubrosEvent,
    PerfilPreInversionCofinanciadorRubrosState> {
  final PerfilPreInversionCofinanciadorRubroUsecaseDB
      perfilPreInversionCofinanciadorRubroUsecaseDB;

  PerfilPreInversionCofinanciadorRubrosBloc(
      {required this.perfilPreInversionCofinanciadorRubroUsecaseDB})
      : super(PerfilPreInversionCofinanciadorRubrosInitial()) {
    on<GetPerfilPreInversionCofinanciadorRubros>((event, emit) async {
      emit(PerfilPreInversionCofinanciadorRubrosLoading());
      await _perfilPreInversionCofinanciadorRubros(event, emit);
    });

    /*  on<GetPerfilPreInversionCofinanciadorRubrosByCofinanciador>(
        (event, emit) async {
      emit(PerfilPreInversionCofinanciadorRubrosLoading());
      await _perfilPreInversionCofinanciadorRubrosByCofinanciador(event, emit);
    }); */
  }

  _perfilPreInversionCofinanciadorRubros(event, emit) async {
    final result = await perfilPreInversionCofinanciadorRubroUsecaseDB
        .getPerfilPreInversionCofinanciadorRubrosUsecaseDB();
    result.fold(
        (failure) => emit(PerfilPreInversionCofinanciadorRubrosError(
            failure.properties.first)),
        (data) => emit(PerfilPreInversionCofinanciadorRubrosLoaded(data)));
  }

  /* _perfilPreInversionCofinanciadorRubrosByCofinanciador(event, emit) async {
    final result = await perfilPreInversionCofinanciadorRubroUsecaseDB
        .getPerfilPreInversionCofinanciadorRubrosByCofinanciadorUsecaseDB(
            event.perfilPreInversionId,
            event.cofinanciadorId,
            event.desembolsoId,
            event.actividadFinancieraId,
            event.rubroId);
    result.fold(
        (failure) => emit(PerfilPreInversionCofinanciadorRubrosError(
            failure.properties.first)),
        (data) => emit(PerfilPreInversionCofinanciadorRubrosLoaded(data)));
  } */
}
