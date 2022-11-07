import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/rubro_entity.dart';
import '../../usecases/rubro/rubro_db_usecase.dart';
import '../../usecases/rubro/rubro_usecase.dart';

part '../rubro/rubro_state.dart';

class RubroCubit extends Cubit<RubroState> {
  final RubroUsecase rubro;
  final RubroUsecaseDB rubroDB;

  RubroCubit({required this.rubro, required this.rubroDB})
      : super(RubroInitial()) {
    getRubroDB();
  }

  void getRubroDB() async {
    final result = await rubroDB.getRubrosUsecaseDB();
    result.fold((failure) => emit(RubroError(failure.properties.first)),
        (data) => emit(RubroLoaded(data)));
  }
}
