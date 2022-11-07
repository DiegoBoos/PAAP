import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/desembolso_entity.dart';
import '../../usecases/desembolso/desembolso_db_usecase.dart';
import '../../usecases/desembolso/desembolso_usecase.dart';

part '../desembolso/desembolso_state.dart';

class DesembolsoCubit extends Cubit<DesembolsoState> {
  final DesembolsoUsecase desembolso;
  final DesembolsoUsecaseDB desembolsoDB;

  DesembolsoCubit({required this.desembolso, required this.desembolsoDB})
      : super(DesembolsoInitial()) {
    getDesembolsoDB();
  }

  void getDesembolsoDB() async {
    final result = await desembolsoDB.getDesembolsosUsecaseDB();
    result.fold((failure) => emit(DesembolsoError(failure.properties.first)),
        (data) => emit(DesembolsoLoaded(data)));
  }
}
