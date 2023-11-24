import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/visita_entity.dart';
import '../../../domain/usecases/visita/visita_db_usecase.dart';

part 'visita_state.dart';

class VisitaCubit extends Cubit<VisitaState> {
  final VisitaUsecaseDB visitaDB;

  VisitaCubit({required this.visitaDB}) : super(VisitaInitial());

  void initState() => emit(VisitaInitial());

  void getVisitaDB(String perfilId, String tipoVisitaId) async {
    final result = await visitaDB.getVisitaUsecaseDB(perfilId, tipoVisitaId);
    result.fold((failure) => emit(VisitaError(failure.properties.first)),
        (data) {
      if (data != null) {
        emit(VisitaLoaded(data));
      } else {
        emit(VisitaInitial());
      }
    });
  }

  void saveVisitaEvaluacionDB(VisitaEntity visitaEntity) async {
    final result = await visitaDB.saveVisitaEvaluacionUsecaseDB(visitaEntity);
    result.fold((failure) => emit(VisitaError(failure.properties.first)),
        (data) {
      emit(VisitaLoaded(data));
    });
  }

  void clearVisitasDB() async {
    final result = await visitaDB.clearVisitasUsecaseDB();
    result.fold((failure) => emit(VisitaError(failure.properties.first)),
        (data) => emit(VisitaCleared()));
  }
}
