import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/desembolso_entity.dart';
import '../../usecases/desembolso/desembolso_db_usecase.dart';

part '../desembolso/desembolso_state.dart';

class DesembolsoCubit extends Cubit<DesembolsoState> {
  final DesembolsoUsecaseDB desembolsoDB;

  DesembolsoCubit({required this.desembolsoDB}) : super(DesembolsosInitial()) {
    getDesembolsosDB();
  }

  void getDesembolsosDB() async {
    final result = await desembolsoDB.getDesembolsosUsecaseDB();
    result.fold((failure) => emit(DesembolsosError(failure.properties.first)),
        (data) => emit(DesembolsosLoaded(data)));
  }
}
