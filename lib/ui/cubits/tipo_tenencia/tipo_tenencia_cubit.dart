import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tipo_tenencia_entity.dart';
import '../../../domain/usecases/tipo_tenencia/tipo_tenencia_db_usecase.dart';
part '../tipo_tenencia/tipo_tenencia_state.dart';

class TipoTenenciaCubit extends Cubit<TipoTenenciaState> {
  final TipoTenenciaUsecaseDB tipoTenenciaDB;

  TipoTenenciaCubit({required this.tipoTenenciaDB})
      : super(TiposTenenciasInitial()) {
    getTiposTenenciasDB();
  }

  void getTiposTenenciasDB() async {
    final result = await tipoTenenciaDB.getTiposTenenciasUsecaseDB();
    result.fold(
        (failure) => emit(TiposTenenciasError(failure.properties.first)),
        (data) => emit(TiposTenenciasLoaded(data)));
  }
}
