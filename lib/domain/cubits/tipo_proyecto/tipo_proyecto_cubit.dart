import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/tipo_proyecto_entity.dart';
import '../../usecases/tipo_proyecto/tipo_proyecto_db_usecase.dart';
import '../../usecases/tipo_proyecto/tipo_proyecto_usecase.dart';

part '../tipo_proyecto/tipo_proyecto_state.dart';

class TipoProyectoCubit extends Cubit<TipoProyectoState> {
  final TipoProyectoUsecase tipoProyecto;
  final TipoProyectoUsecaseDB tipoProyectoDB;

  TipoProyectoCubit({required this.tipoProyecto, required this.tipoProyectoDB})
      : super(TipoProyectoInitial()) {
    getTipoProyectoDB();
  }

  void getTipoProyectoDB() async {
    final result = await tipoProyectoDB.getTiposProyectosUsecaseDB();
    result.fold((failure) => emit(TipoProyectoError(failure.properties.first)),
        (data) => emit(TipoProyectoLoaded(data)));
  }
}
