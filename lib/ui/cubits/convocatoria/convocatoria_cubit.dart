import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/convocatoria_entity.dart';
import '../../../domain/usecases/convocatoria/convocatoria_db_usecase.dart';

part 'convocatoria_state.dart';

class ConvocatoriaCubit extends Cubit<ConvocatoriaState> {
  final ConvocatoriaUsecaseDB convocatoriaDB;

  ConvocatoriaCubit({required this.convocatoriaDB})
      : super(ConvocatoriasInitial()) {
    getConvocatoriasDB();
  }

  void getConvocatoriasDB() async {
    final result = await convocatoriaDB.getConvocatoriasUsecaseDB();
    result.fold((failure) => emit(ConvocatoriasError(failure.properties.first)),
        (data) => emit(ConvocatoriasLoaded(data)));
  }
}
