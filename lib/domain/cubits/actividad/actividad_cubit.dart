import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/actividad_entity.dart';
import '../../usecases/actividad/actividad_db_usecase.dart';

part 'actividad_state.dart';

class ActividadCubit extends Cubit<ActividadState> {
  final ActividadUsecaseDB actividadDB;

  ActividadCubit({required this.actividadDB}) : super(ActividadInitial());

  void getActividadDB(String id) async {
    final result = await actividadDB.getActividadUsecaseDB(id);
    result.fold((failure) => emit(ActividadError(failure.properties.first)),
        (data) => emit(ActividadLoaded(data)));
  }
}
