import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paap/domain/usecases/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_db_usecase.dart';

import '../../entities/perfil_preinversion_cofinanciador_desembolso_entity.dart';

part 'perfil_preinversion_cofinanciador_desembolsos_event.dart';
part 'perfil_preinversion_cofinanciador_desembolsos_state.dart';

class PerfilPreInversionCofinanciadorDesembolsosBloc extends Bloc<
    PerfilPreInversionCofinanciadorDesembolsosEvent,
    PerfilPreInversionCofinanciadorDesembolsosState> {
  final PerfilPreInversionCofinanciadorDesembolsoUsecaseDB
      perfilPreInversionCofinanciadorDesembolsoUsecaseDB;

  PerfilPreInversionCofinanciadorDesembolsosBloc(
      {required this.perfilPreInversionCofinanciadorDesembolsoUsecaseDB})
      : super(PerfilPreInversionCofinanciadorDesembolsosInitial()) {
    on<GetPerfilPreInversionCofinanciadorDesembolsos>((event, emit) async {
      emit(PerfilPreInversionCofinanciadorDesembolsosLoading());
      await _getPerfilPreInversionCofinanciadorDesembolsos(event, emit);
    });

    on<GetPerfilPreInversionCofinanciadorDesembolsosByCofinanciador>(
        (event, emit) async {
      emit(PerfilPreInversionCofinanciadorDesembolsosLoading());
      await _getPerfilPreInversionCofinanciadorDesembolsosByCofinanciador(
          event, emit);
    });
  }

  _getPerfilPreInversionCofinanciadorDesembolsos(event, emit) async {
    final result = await perfilPreInversionCofinanciadorDesembolsoUsecaseDB
        .getPerfilPreInversionCofinanciadorDesembolsosUsecaseDB();
    result.fold(
        (failure) => emit(PerfilPreInversionCofinanciadorDesembolsosError(
            failure.properties.first)),
        (data) => emit(PerfilPreInversionCofinanciadorDesembolsosLoaded(data)));
  }

  _getPerfilPreInversionCofinanciadorDesembolsosByCofinanciador(
      event, emit) async {
    final result = await perfilPreInversionCofinanciadorDesembolsoUsecaseDB
        .getPerfilPreInversionCofinanciadorDesembolsosByCofinanciadorUsecaseDB(
            event.cofinanciadorId);
    result.fold(
        (failure) => emit(PerfilPreInversionCofinanciadorDesembolsosError(
            failure.properties.first)),
        (data) => emit(PerfilPreInversionCofinanciadorDesembolsosLoaded(data)));
  }
}
