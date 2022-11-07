import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/nivel_escolar_entity.dart';
import '../../usecases/nivel_escolar/nivel_escolar_db_usecase.dart';
import '../../usecases/nivel_escolar/nivel_escolar_usecase.dart';

part '../nivel_escolar/nivel_escolar_state.dart';

class NivelEscolarCubit extends Cubit<NivelEscolarState> {
  final NivelEscolarUsecase nivelEscolar;
  final NivelEscolarUsecaseDB nivelEscolarDB;

  NivelEscolarCubit({required this.nivelEscolar, required this.nivelEscolarDB})
      : super(NivelEscolarInitial()) {
    getNivelEscolarDB();
  }

  void getNivelEscolarDB() async {
    final result = await nivelEscolarDB.getNivelesEscolaresUsecaseDB();
    result.fold((failure) => emit(NivelEscolarError(failure.properties.first)),
        (data) => emit(NivelEscolarLoaded(data)));
  }
}
