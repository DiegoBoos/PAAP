import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/residencia_entity.dart';
import '../../usecases/residencia/residencia_db_usecase.dart';
import '../../usecases/residencia/residencia_usecase.dart';

part '../residencia/residencia_state.dart';

class ResidenciaCubit extends Cubit<ResidenciaState> {
  final ResidenciaUsecase residencia;
  final ResidenciaUsecaseDB residenciaDB;

  ResidenciaCubit({required this.residencia, required this.residenciaDB})
      : super(ResidenciaInitial()) {
    getResidenciaDB();
  }

  void getResidenciaDB() async {
    final result = await residenciaDB.getResidenciasUsecaseDB();
    result.fold((failure) => emit(ResidenciaError(failure.properties.first)),
        (data) => emit(ResidenciaLoaded(data)));
  }
}
