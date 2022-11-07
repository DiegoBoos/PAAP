import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/tipo_tenencia_entity.dart';
import '../../usecases/tipo_tenencia/tipo_tenencia_db_usecase.dart';
import '../../usecases/tipo_tenencia/tipo_tenencia_usecase.dart';

part '../tipo_tenencia/tipo_tenencia_state.dart';

class TipoTenenciaCubit extends Cubit<TipoTenenciaState> {
  final TipoTenenciaUsecase tipoTenencia;
  final TipoTenenciaUsecaseDB tipoTenenciaDB;

  TipoTenenciaCubit({required this.tipoTenencia, required this.tipoTenenciaDB})
      : super(TipoTenenciaInitial()) {
    getTipoTenenciaDB();
  }

  void getTipoTenenciaDB() async {
    final result = await tipoTenenciaDB.getTiposTenenciasUsecaseDB();
    result.fold((failure) => emit(TipoTenenciaError(failure.properties.first)),
        (data) => emit(TipoTenenciaLoaded(data)));
  }
}
