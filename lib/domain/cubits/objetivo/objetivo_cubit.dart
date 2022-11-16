import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/objetivo_entity.dart';
import '../../usecases/objetivo/objetivo_db_usecase.dart';

part '../objetivo/objetivo_state.dart';

class ObjetivoCubit extends Cubit<ObjetivoState> {
  final ObjetivoUsecaseDB objetivoDB;

  ObjetivoCubit({required this.objetivoDB}) : super(ObjetivosInitial()) {
    getObjetivosDB();
  }

  void getObjetivosDB() async {
    final result = await objetivoDB.getObjetivosUsecaseDB();
    result.fold((failure) => emit(ObjetivosError(failure.properties.first)),
        (data) => emit(ObjetivosLoaded(data)));
  }
}
