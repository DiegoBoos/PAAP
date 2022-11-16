import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/proyecto_entity.dart';
import '../../usecases/proyecto/proyecto_db_usecase.dart';

part '../proyecto/proyecto_state.dart';

class ProyectoCubit extends Cubit<ProyectoState> {
  final ProyectoUsecaseDB proyectoDB;

  ProyectoCubit({required this.proyectoDB}) : super(ProyectosInitial()) {
    getProyectosDB();
  }

  void getProyectosDB() async {
    final result = await proyectoDB.getProyectosUsecaseDB();
    result.fold((failure) => emit(ProyectosError(failure.properties.first)),
        (data) => emit(ProyectosLoaded(data)));
  }
}
