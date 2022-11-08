import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/estado_civil_entity.dart';
import '../../usecases/estado_civil/estado_civil_db_usecase.dart';

part '../estado_civil/estado_civil_state.dart';

class EstadoCivilCubit extends Cubit<EstadoCivilState> {
  final EstadoCivilUsecaseDB estadoCivilDB;

  EstadoCivilCubit({required this.estadoCivilDB})
      : super(EstadosCivilesInitial()) {
    getEstadosCivilesDB();
  }

  void getEstadosCivilesDB() async {
    final result = await estadoCivilDB.getEstadosCivilesUsecaseDB();
    result.fold(
        (failure) => emit(EstadosCivilesError(failure.properties.first)),
        (data) => emit(EstadosCivilesLoaded(data)));
  }
}
