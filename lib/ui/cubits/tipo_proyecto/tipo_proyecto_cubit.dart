import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tipo_proyecto_entity.dart';
import '../../../domain/usecases/tipo_proyecto/tipo_proyecto_db_usecase.dart';

part '../tipo_proyecto/tipo_proyecto_state.dart';

class TipoProyectoCubit extends Cubit<TipoProyectoState> {
  final TipoProyectoUsecaseDB tipoProyectoDB;

  TipoProyectoCubit({required this.tipoProyectoDB})
      : super(TiposProyectosInitial()) {
    getTiposProyectosDB();
  }

  void getTiposProyectosDB() async {
    final result = await tipoProyectoDB.getTiposProyectosUsecaseDB();
    result.fold(
        (failure) => emit(TiposProyectosError(failure.properties.first)),
        (data) => emit(TiposProyectosLoaded(data)));
  }
}
