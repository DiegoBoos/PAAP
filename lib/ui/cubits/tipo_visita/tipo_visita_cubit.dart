import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tipo_visita_entity.dart';
import '../../../domain/usecases/tipo_visita/tipo_visita_db_usecase.dart';

part 'tipo_visita_state.dart';

class TipoVisitaCubit extends Cubit<TipoVisitaState> {
  final TipoVisitaUsecaseDB tipoVisitaDB;

  TipoVisitaCubit({required this.tipoVisitaDB}) : super(TiposVisitasInitial()) {
    getTiposVisitasDB();
  }

  void getTiposVisitasDB() async {
    final result = await tipoVisitaDB.getTiposVisitasUsecaseDB();
    result.fold((failure) => emit(TiposVisitasError(failure.properties.first)),
        (data) => emit(TiposVisitasLoaded(data)));
  }
}
