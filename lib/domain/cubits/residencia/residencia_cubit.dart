import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/residencia_entity.dart';
import '../../usecases/residencia/residencia_db_usecase.dart';

part '../residencia/residencia_state.dart';

class ResidenciaCubit extends Cubit<ResidenciaState> {
  final ResidenciaUsecaseDB residenciaDB;

  ResidenciaCubit({required this.residenciaDB}) : super(ResidenciasInitial()) {
    getResidenciasDB();
  }

  void getResidenciasDB() async {
    final result = await residenciaDB.getResidenciasUsecaseDB();
    result.fold((failure) => emit(ResidenciasError(failure.properties.first)),
        (data) => emit(ResidenciasLoaded(data)));
  }
}
