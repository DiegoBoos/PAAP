import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tipo_identificacion_entity.dart';
import '../../../domain/usecases/tipo_identificacion/tipo_identificacion_db_usecase.dart';

part '../tipo_identificacion/tipo_identificacion_state.dart';

class TipoIdentificacionCubit extends Cubit<TipoIdentificacionState> {
  final TipoIdentificacionUsecaseDB tipoIdentificacionDB;

  TipoIdentificacionCubit({required this.tipoIdentificacionDB})
      : super(TiposIdentificacionesInitial()) {
    getTiposIdentificacionesDB();
  }

  void getTiposIdentificacionesDB() async {
    final result =
        await tipoIdentificacionDB.getTiposIdentificacionesUsecaseDB();
    result.fold(
        (failure) => emit(TiposIdentificacionesError(failure.properties.first)),
        (data) => emit(TiposIdentificacionesLoaded(data)));
  }
}
