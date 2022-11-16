import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/indicador_entity.dart';
import '../../usecases/indicador/indicador_db_usecase.dart';

part 'indicador_state.dart';

class IndicadorCubit extends Cubit<IndicadorState> {
  final IndicadorUsecaseDB indicadorDB;

  IndicadorCubit({required this.indicadorDB}) : super(IndicadorInitial());

  void getIndicadorDB(String id) async {
    final result = await indicadorDB.getIndicadorUsecaseDB(id);
    result.fold((failure) => emit(IndicadorError(failure.properties.first)),
        (data) => emit(IndicadorLoaded(data)));
  }
}
