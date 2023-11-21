import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/estado_visita_entity.dart';
import '../../../domain/usecases/estado_visita/estado_visita_db_usecase.dart';

part 'estado_visita_state.dart';

class EstadoVisitaCubit extends Cubit<EstadoVisitaState> {
  final EstadoVisitaUsecaseDB estadovisitaDB;

  EstadoVisitaCubit({required this.estadovisitaDB})
      : super(EstadosVisitasInitial()) {
    getEstadoVisitasDB();
  }

  void getEstadoVisitasDB() async {
    final result = await estadovisitaDB.getEstadosVisitasUsecaseDB();
    result.fold(
        (failure) => emit(EstadosVisitasError(failure.properties.first)),
        (data) => emit(EstadosVisitasLoaded(data)));
  }
}
