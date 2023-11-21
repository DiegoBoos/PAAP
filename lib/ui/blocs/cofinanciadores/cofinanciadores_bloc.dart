import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/cofinanciador_entity.dart';
import '../../../domain/usecases/cofinanciador/cofinanciador_db_usecase.dart';

part 'cofinanciadores_event.dart';
part 'cofinanciadores_state.dart';

class CofinanciadoresBloc
    extends Bloc<CofinanciadoresEvent, CofinanciadoresState> {
  final CofinanciadorUsecaseDB cofinanciadorUsecaseDB;
  CofinanciadoresBloc({required this.cofinanciadorUsecaseDB})
      : super(CofinanciadoresInitial()) {
    on<GetCofinanciadoresByDepartamento>((event, emit) async {
      emit(CofinanciadoresLoading());
      await _getCofinanciadoresByDepartamento(event, emit);
    });
  }

  _getCofinanciadoresByDepartamento(event, emit) async {
    final result = await cofinanciadorUsecaseDB.getCofinanciadoresUsecaseDB();
    result.fold(
        (failure) => emit(CofinanciadoresError(failure.properties.first)),
        (data) => emit(CofinanciadoresLoaded(cofinanciadoresLoaded: data)));
  }
}
