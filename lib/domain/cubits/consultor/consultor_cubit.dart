import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/consultor_entity.dart';
import '../../usecases/consultor/consultor_db_usecase.dart';

part 'consultor_state.dart';

class ConsultorCubit extends Cubit<ConsultorState> {
  final ConsultorUsecaseDB consultorDB;

  ConsultorCubit({required this.consultorDB}) : super(ConsultorInitial());

  void getConsultorDB(String id) async {
    final result = await consultorDB.getConsultorUsecaseDB(id);
    result.fold((failure) => emit(ConsultorError(failure.properties.first)),
        (data) => emit(ConsultorLoaded(data)));
  }
}
