import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/frecuencia_entity.dart';
import '../../usecases/frecuencia/frecuencia_db_usecase.dart';
import '../../usecases/frecuencia/frecuencia_usecase.dart';

part '../frecuencia/frecuencia_state.dart';

class FrecuenciaCubit extends Cubit<FrecuenciaState> {
  final FrecuenciaUsecase frecuencia;
  final FrecuenciaUsecaseDB frecuenciaDB;

  FrecuenciaCubit({required this.frecuencia, required this.frecuenciaDB})
      : super(FrecuenciaInitial()) {
    getFrecuenciaDB();
  }

  void getFrecuenciaDB() async {
    final result = await frecuenciaDB.getFrecuenciasUsecaseDB();
    result.fold((failure) => emit(FrecuenciaError(failure.properties.first)),
        (data) => emit(FrecuenciaLoaded(data)));
  }
}
