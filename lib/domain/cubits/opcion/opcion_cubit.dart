import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/opcion_entity.dart';
import '../../usecases/opcion/opcion_db_usecase.dart';

part 'opcion_state.dart';

class OpcionCubit extends Cubit<OpcionState> {
  final OpcionUsecaseDB opcionDB;

  OpcionCubit({required this.opcionDB}) : super(OpcionesInitial()) {
    getOpcionesDB();
  }

  void getOpcionesDB() async {
    final result = await opcionDB.getOpcionesUsecaseDB();
    result.fold((failure) => emit(OpcionesError(failure.properties.first)),
        (data) => emit(OpcionesLoaded(data)));
  }
}
