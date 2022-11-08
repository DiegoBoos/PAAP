import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/frecuencia_entity.dart';
import '../../usecases/frecuencia/frecuencia_db_usecase.dart';

part '../frecuencia/frecuencia_state.dart';

class FrecuenciaCubit extends Cubit<FrecuenciaState> {
  final FrecuenciaUsecaseDB frecuenciaDB;

  FrecuenciaCubit({required this.frecuenciaDB}) : super(FrecuenciasInitial()) {
    getFrecuenciasDB();
  }

  void getFrecuenciasDB() async {
    final result = await frecuenciaDB.getFrecuenciasUsecaseDB();
    result.fold((failure) => emit(FrecuenciasError(failure.properties.first)),
        (data) => emit(FrecuenciasLoaded(data)));
  }
}
