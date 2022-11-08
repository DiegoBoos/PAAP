import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/nivel_escolar_entity.dart';
import '../../usecases/nivel_escolar/nivel_escolar_db_usecase.dart';

part '../nivel_escolar/nivel_escolar_state.dart';

class NivelEscolarCubit extends Cubit<NivelEscolarState> {
  final NivelEscolarUsecaseDB nivelEscolarDB;

  NivelEscolarCubit({required this.nivelEscolarDB})
      : super(NivelesEscolaresInitial()) {
    getNivelesEscolaresDB();
  }

  void getNivelesEscolaresDB() async {
    final result = await nivelEscolarDB.getNivelesEscolaresUsecaseDB();
    result.fold(
        (failure) => emit(NivelesEscolaresError(failure.properties.first)),
        (data) => emit(NivelesEscolaresLoaded(data)));
  }
}
