import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/agrupacion_entity.dart';
import '../../usecases/agrupacion/agrupacion_db_usecase.dart';
import '../../usecases/agrupacion/agrupacion_usecase.dart';

part 'agrupacion_state.dart';

class AgrupacionCubit extends Cubit<AgrupacionState> {
  final AgrupacionUsecase agrupacion;
  final AgrupacionUsecaseDB agrupacionDB;

  AgrupacionCubit({required this.agrupacion, required this.agrupacionDB})
      : super(AgrupacionInitial()) {
    getAgrupacionDB();
  }

  void getAgrupacionDB() async {
    final result = await agrupacionDB.getAgrupacionesUsecaseDB();
    result.fold((failure) => emit(AgrupacionError(failure.properties.first)),
        (data) => emit(AgrupacionLoaded(data)));
  }
}
