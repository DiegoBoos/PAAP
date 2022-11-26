import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/opcion_entity.dart';
import '../../usecases/opcion/opcion_db_usecase.dart';

part 'opcion_state.dart';

class OpcionCubit extends Cubit<OpcionState> {
  final OpcionUsecaseDB opcionDB;

  OpcionCubit({required this.opcionDB}) : super(OpcionesInitial());

  Future<List<OpcionEntity>?> getOpcionesDB() async {
    final result = await opcionDB.getOpcionesUsecaseDB();
    return result.fold((failure) => [], (data) => data);
  }

  void initState() => emit(OpcionesInitial());
}
