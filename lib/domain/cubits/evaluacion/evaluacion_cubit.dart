import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/evaluacion_entity.dart';
import '../../usecases/evaluacion/evaluacion_db_usecase.dart';

part 'evaluacion_state.dart';

class EvaluacionCubit extends Cubit<EvaluacionState> {
  final EvaluacionUsecaseDB evaluacionDB;

  EvaluacionCubit({required this.evaluacionDB}) : super(EvaluacionInitial());

  void getEvaluacionDB(String id) async {
    final result = await evaluacionDB.getEvaluacionUsecaseDB(id);
    result.fold((failure) => emit(EvaluacionError(failure.properties.first)),
        (data) => emit(EvaluacionSaved()));
  }

  void saveEvaluacionDB(EvaluacionEntity evaluacionEntity) async {
    final result = await evaluacionDB.saveEvaluacionUsecaseDB(evaluacionEntity);
    result.fold((failure) => emit(EvaluacionError(failure.properties.first)),
        (data) => emit(EvaluacionSaved()));
  }

  void clearEvaluacionsDB() async {
    final result = await evaluacionDB.clearEvaluacionesUsecaseDB();
    result.fold((failure) => emit(EvaluacionError(failure.properties.first)),
        (data) => emit(EvaluacionCleared()));
  }
}
