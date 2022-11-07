import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/tipo_identificacion_entity.dart';
import '../../usecases/tipo_identificacion/tipo_identificacion_db_usecase.dart';
import '../../usecases/tipo_identificacion/tipo_identificacion_usecase.dart';

part '../tipo_identificacion/tipo_identificacion_state.dart';

class TipoIdentificacionCubit extends Cubit<TipoIdentificacionState> {
  final TipoIdentificacionUsecase tipoIdentificacion;
  final TipoIdentificacionUsecaseDB tipoIdentificacionDB;

  TipoIdentificacionCubit(
      {required this.tipoIdentificacion, required this.tipoIdentificacionDB})
      : super(TipoIdentificacionInitial()) {
    getTipoIdentificacionDB();
  }

  void getTipoIdentificacionDB() async {
    final result =
        await tipoIdentificacionDB.getTiposIdentificacionesUsecaseDB();
    result.fold(
        (failure) => emit(TipoIdentificacionError(failure.properties.first)),
        (data) => emit(TipoIdentificacionLoaded(data)));
  }
}
