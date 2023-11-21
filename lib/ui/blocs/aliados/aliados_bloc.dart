import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/aliado_entity.dart';
import '../../../domain/usecases/aliado/aliado_db_usecase.dart';

part 'aliados_event.dart';
part 'aliados_state.dart';

class AliadosBloc extends Bloc<AliadosEvent, AliadosState> {
  final AliadoUsecaseDB aliadoUsecaseDB;
  AliadosBloc({required this.aliadoUsecaseDB}) : super(AliadosInitial()) {
    on(<InitState>(event, emit) async {
      emit(AliadosInitial());
    });

    on<GetAliados>((event, emit) async {
      emit(AliadosLoading());
      await _getAliados(event, emit);
    });
  }

  _getAliados(event, emit) async {
    final result = await aliadoUsecaseDB.getAliadosUsecaseDB();
    result.fold((failure) => emit(AliadosError(failure.properties.first)),
        (data) => emit(AliadosLoaded(data!)));
  }
}
