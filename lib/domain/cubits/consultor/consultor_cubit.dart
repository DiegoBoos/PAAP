import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/consultor_entity.dart';
import '../../usecases/consultor/consultor_db_usecase.dart';
import '../../usecases/consultor/consultor_usecase.dart';

part 'consultor_state.dart';

class ConsultorCubit extends Cubit<ConsultorState> {
  final ConsultorUsecase consultor;
  final ConsultorUsecaseDB consultorDB;

  ConsultorCubit({required this.consultor, required this.consultorDB})
      : super(ConsultorInitial()) {
    getConsultorDB();
  }

  void getConsultorDB() async {
    final result = await consultorDB.getConsultoresUsecaseDB();
    result.fold((failure) => emit(ConsultorError(failure.properties.first)),
        (data) => emit(ConsultorLoaded(data)));
  }
}
