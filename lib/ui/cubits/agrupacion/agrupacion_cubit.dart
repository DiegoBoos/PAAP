import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/agrupacion_entity.dart';
import '../../../domain/usecases/agrupacion/agrupacion_db_usecase.dart';

part 'agrupacion_state.dart';

class AgrupacionCubit extends Cubit<AgrupacionState> {
  final AgrupacionUsecaseDB agrupacionDB;

  AgrupacionCubit({required this.agrupacionDB}) : super(AgrupacionesInitial());

  Future<void> getAgrupacionesDB(String convocatoriaId) async {
    final result = await agrupacionDB.getAgrupacionesUsecaseDB(convocatoriaId);
    result.fold((failure) => emit(AgrupacionesError(failure.properties.first)),
        (data) => emit(AgrupacionesLoaded(data)));
  }

  void initState() => emit(AgrupacionesInitial());
}
