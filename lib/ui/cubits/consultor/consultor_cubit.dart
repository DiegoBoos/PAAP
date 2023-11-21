import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/consultor_entity.dart';
import '../../../domain/usecases/consultor/consultor_db_usecase.dart';

part 'consultor_state.dart';

class ConsultorCubit extends Cubit<ConsultorState> {
  final ConsultorUsecaseDB consultorDB;

  ConsultorCubit({required this.consultorDB}) : super(ConsultoresInitial()) {
    getConsultoresDB();
  }

  void getConsultoresDB() async {
    final result = await consultorDB.getConsultoresUsecaseDB();
    result.fold((failure) => emit(ConsultoresError(failure.properties.first)),
        (data) => emit(ConsultoresLoaded(data)));
  }
}
