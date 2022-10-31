import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/convocatoria_entity.dart';
import '../../usecases/convocatoria/convocatoria_db_usecase.dart';
import '../../usecases/convocatoria/convocatoria_usecase.dart';

part 'convocatoria_state.dart';

class ConvocatoriaCubit extends Cubit<ConvocatoriaState> {
  final ConvocatoriaUsecase convocatoria;
  final ConvocatoriaUsecaseDB convocatoriaDB;

  ConvocatoriaCubit({required this.convocatoria, required this.convocatoriaDB})
      : super(ConvocatoriaInitial()) {
    getConvocatoriaDB();
  }

  void getConvocatoriaDB() async {
    final result = await convocatoriaDB.getConvocatoriasUsecaseDB();
    result.fold((failure) => emit(ConvocatoriaError(failure.properties.first)),
        (data) => emit(ConvocatoriaLoaded(data)));
  }
}
