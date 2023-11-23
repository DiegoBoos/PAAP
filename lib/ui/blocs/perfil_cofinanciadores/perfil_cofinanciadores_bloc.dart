import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/perfil_cofinanciador_entity.dart';
import '../../../domain/usecases/perfil_cofinanciador/perfil_cofinanciador_db_usecase.dart';

part 'perfil_cofinanciadores_event.dart';
part 'perfil_cofinanciadores_state.dart';

class PerfilCofinanciadoresBloc
    extends Bloc<PerfilCofinanciadoresEvent, PerfilCofinanciadoresState> {
  final PerfilCofinanciadorUsecaseDB perfilCofinanciadorUsecaseDB;
  PerfilCofinanciadoresBloc({required this.perfilCofinanciadorUsecaseDB})
      : super(PerfilCofinanciadoresInitial()) {
    on(<InitState>(event, emit) async {
      emit(PerfilCofinanciadoresInitial());
    });

    on<GetPerfilCofinanciadores>((event, emit) async {
      emit(PerfilCofinanciadoresLoading());
      await _getPerfilCofinanciadores(event, emit);
    });
  }

  _getPerfilCofinanciadores(event, emit) async {
    final result = await perfilCofinanciadorUsecaseDB
        .getPerfilCofinanciadoresUsecaseDB(event.perfilId);
    result.fold(
        (failure) => emit(PerfilCofinanciadoresError(failure.properties.first)),
        (data) => emit(PerfilCofinanciadoresLoaded(data)));
  }
}
