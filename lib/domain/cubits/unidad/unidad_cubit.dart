import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/unidad_entity.dart';
import '../../usecases/unidad/unidad_db_usecase.dart';
import '../../usecases/unidad/unidad_usecase.dart';

part 'unidad_state.dart';

class UnidadCubit extends Cubit<UnidadState> {
  final UnidadUsecase unidad;
  final UnidadUsecaseDB unidadDB;

  UnidadCubit({required this.unidad, required this.unidadDB})
      : super(UnidadInitial()) {
    getUnidadDB();
  }

  void getUnidadDB() async {
    final result = await unidadDB.getUnidadesUsecaseDB();
    result.fold((failure) => emit(UnidadError(failure.properties.first)),
        (data) => emit(UnidadLoaded(data)));
  }
}
