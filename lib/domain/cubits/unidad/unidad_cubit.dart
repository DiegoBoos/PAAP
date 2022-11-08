import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/unidad_entity.dart';
import '../../usecases/unidad/unidad_db_usecase.dart';

part 'unidad_state.dart';

class UnidadCubit extends Cubit<UnidadState> {
  final UnidadUsecaseDB unidadDB;

  UnidadCubit({required this.unidadDB}) : super(UnidadesInitial()) {
    getUnidadesDB();
  }

  void getUnidadesDB() async {
    final result = await unidadDB.getUnidadesUsecaseDB();
    result.fold((failure) => emit(UnidadesError(failure.properties.first)),
        (data) => emit(UnidadesLoaded(data)));
  }
}
