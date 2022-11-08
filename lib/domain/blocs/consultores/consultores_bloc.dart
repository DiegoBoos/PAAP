import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/consultor_entity.dart';
import '../../usecases/consultor/consultor_db_usecase.dart';

part 'consultores_event.dart';
part 'consultores_state.dart';

class ConsultoresBloc extends Bloc<ConsultoresEvent, ConsultoresState> {
  final ConsultorUsecaseDB beneficiarioUsecaseDB;
  ConsultoresBloc({required this.beneficiarioUsecaseDB})
      : super(ConsultoresInitial()) {
    on<GetConsultores>((event, emit) async {
      emit(ConsultoresLoading());
      await _getConsultores(event, emit);
    });
  }

  _getConsultores(event, emit) async {
    final result = await beneficiarioUsecaseDB.getConsultoresUsecaseDB();
    result.fold((failure) => emit(ConsultoresError(failure.properties.first)),
        (data) => emit(ConsultoresLoaded(consultoresLoaded: data)));
  }
}
