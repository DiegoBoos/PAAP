import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paap/domain/entities/visita_entity.dart';

import '../../usecases/visita/visita_db_usecase.dart';

part 'visita_state.dart';

class VisitaCubit extends Cubit<VisitaState> {
  final VisitaUsecaseDB visitaDB;

  VisitaCubit({required this.visitaDB}) : super(VisitaInitial());

  void getVisitaDB(VisitaEntity visitaEntity) async {
    final result = await visitaDB.getVisitaUsecaseDB(visitaEntity);
    result.fold((failure) => emit(VisitaError(failure.properties.first)),
        (data) => emit(VisitaLoaded(data)));
  }

  void clearVisitasDB() async {
    final result = await visitaDB.clearVisitasUsecaseDB();
    result.fold((failure) => emit(VisitaError(failure.properties.first)),
        (data) => emit(VisitaCleared()));
  }

  void initState() => emit(VisitaInitial());
}
