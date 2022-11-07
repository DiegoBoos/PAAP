import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/estado_civil_entity.dart';
import '../../usecases/estado_civil/estado_civil_db_usecase.dart';
import '../../usecases/estado_civil/estado_civil_usecase.dart';

part '../estado_civil/estado_civil_state.dart';

class EstadoCivilCubit extends Cubit<EstadoCivilState> {
  final EstadoCivilUsecase estadoCivil;
  final EstadoCivilUsecaseDB estadoCivilDB;

  EstadoCivilCubit({required this.estadoCivil, required this.estadoCivilDB})
      : super(EstadoCivilInitial()) {
    getEstadoCivilDB();
  }

  void getEstadoCivilDB() async {
    final result = await estadoCivilDB.getEstadosCivilesUsecaseDB();
    result.fold((failure) => emit(EstadoCivilError(failure.properties.first)),
        (data) => emit(EstadoCivilLoaded(data)));
  }
}
