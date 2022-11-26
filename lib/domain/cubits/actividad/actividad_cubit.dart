import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/actividad_entity.dart';
import '../../usecases/actividad/actividad_db_usecase.dart';

part 'actividad_state.dart';

class ActividadCubit extends Cubit<ActividadState> {
  final ActividadUsecaseDB actividadDB;

  ActividadCubit({required this.actividadDB}) : super(ActividadesInitial()) {
    getActividadesDB();
  }

  void getActividadesDB() async {
    final result = await actividadDB.getActividadesUsecaseDB();
    result.fold((failure) => emit(ActividadesError(failure.properties.first)),
        (data) => emit(ActividadesLoaded(data)));
  }
}
