import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/tipo_entidad_entity.dart';
import '../../usecases/tipo_entidad/tipo_entidad_db_usecase.dart';
import '../../usecases/tipo_entidad/tipo_entidad_usecase.dart';

part '../tipo_entidad/tipo_entidad_state.dart';

class TipoEntidadCubit extends Cubit<TipoEntidadState> {
  final TipoEntidadUsecase tipoEntidad;
  final TipoEntidadUsecaseDB tipoEntidadDB;

  TipoEntidadCubit({required this.tipoEntidad, required this.tipoEntidadDB})
      : super(TipoEntidadInitial()) {
    getTipoEntidadDB();
  }

  void getTipoEntidadDB() async {
    final result = await tipoEntidadDB.getTiposEntidadesUsecaseDB();
    result.fold((failure) => emit(TipoEntidadError(failure.properties.first)),
        (data) => emit(TipoEntidadLoaded(data)));
  }
}
