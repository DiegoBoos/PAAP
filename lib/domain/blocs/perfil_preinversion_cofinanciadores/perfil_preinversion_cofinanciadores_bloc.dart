import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_cofinanciador_entity.dart';
import '../../usecases/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_db_usecase.dart';

part 'perfil_preinversion_cofinanciadores_event.dart';
part 'perfil_preinversion_cofinanciadores_state.dart';

class PerfilPreInversionCofinanciadoresBloc extends Bloc<
    PerfilPreInversionCofinanciadoresEvent,
    PerfilPreInversionCofinanciadoresState> {
  final PerfilPreInversionCofinanciadorUsecaseDB
      perfilPreInversionCofinanciadoresDB;

  PerfilPreInversionCofinanciadoresBloc({
    required this.perfilPreInversionCofinanciadoresDB,
  }) : super(PerfilPreInversionCofinanciadoresInitial()) {
    on<GetPerfilPreInversionCofinanciadores>((event, emit) async {
      emit(PerfilPreInversionCofinanciadoresLoading());
      await _getPerfilPreInversionCofinanciadores(event, emit);
    });
  }

  _getPerfilPreInversionCofinanciadores(event, emit) async {
    final result = await perfilPreInversionCofinanciadoresDB
        .getPerfilesPreInversionesCofinanciadoresUsecaseDB(
            event.perfilPreInversionId);
    result.fold(
        (failure) => emit(
            PerfilPreInversionCofinanciadoresError(failure.properties.first)),
        (data) => emit(PerfilPreInversionCofinanciadoresLoaded(
            perfilPreInversionCofinanciadoresLoaded: data)));
  }
}
