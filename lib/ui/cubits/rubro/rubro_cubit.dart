import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/rubro_entity.dart';
import '../../../domain/usecases/rubro/rubro_db_usecase.dart';

part '../rubro/rubro_state.dart';

class RubroCubit extends Cubit<RubroState> {
  final RubroUsecaseDB rubroDB;

  RubroCubit({required this.rubroDB}) : super(RubrosInitial());

  void getRubrosDB() async {
    final result = await rubroDB.getRubrosUsecaseDB();
    result.fold((failure) => emit(RubrosError(failure.properties.first)),
        (data) => emit(RubrosLoaded(data)));
  }
}
