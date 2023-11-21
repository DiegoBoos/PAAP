import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tipo_entidad_entity.dart';
import '../../../domain/usecases/tipo_entidad/tipo_entidad_db_usecase.dart';
part '../tipo_entidad/tipo_entidad_state.dart';

class TipoEntidadCubit extends Cubit<TipoEntidadState> {
  final TipoEntidadUsecaseDB tipoEntidadDB;

  TipoEntidadCubit({required this.tipoEntidadDB})
      : super(TiposEntidadesInitial()) {
    getTiposEntidadesDB();
  }

  void getTiposEntidadesDB() async {
    final result = await tipoEntidadDB.getTiposEntidadesUsecaseDB();
    result.fold(
        (failure) => emit(TiposEntidadesError(failure.properties.first)),
        (data) => emit(TiposEntidadesLoaded(data)));
  }
}
