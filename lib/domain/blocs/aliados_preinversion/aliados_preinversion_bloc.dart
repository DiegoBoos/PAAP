import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/aliado_preinversion_entity.dart';
import '../../usecases/aliado_preinversion/aliado_preinversion_db_usecase.dart';

part 'aliados_preinversion_event.dart';
part 'aliados_preinversion_state.dart';

class AliadosPreinversionBloc
    extends Bloc<AliadosPreinversionEvent, AliadosPreinversionState> {
  final AliadoPreinversionUsecaseDB aliadosPreinversionDB;

  AliadosPreinversionBloc({
    required this.aliadosPreinversionDB,
  }) : super(AliadosPreinversionInitial()) {
    on<GetAliadosPreinversion>((event, emit) async {
      emit(AliadosPreinversionLoading());
      await _getAliadosPreinversion(event, emit);
    });
  }

  _getAliadosPreinversion(event, emit) async {
    final result =
        await aliadosPreinversionDB.getAliadosPreinversionUsecaseDB();
    result.fold(
        (failure) => emit(AliadosPreinversionError(failure.properties.first)),
        (data) =>
            emit(AliadosPreinversionLoaded(aliadosPreinversionLoaded: data)));
  }
}
