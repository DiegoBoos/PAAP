import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/meta_indicador_entity.dart';
import '../../usecases/meta_indicador/meta_indicador_db_usecase.dart';

part '../meta_indicador/meta_indicador_state.dart';

class MetaIndicadorCubit extends Cubit<MetaIndicadorState> {
  final MetaIndicadorUsecaseDB metaIndicadorDB;

  MetaIndicadorCubit({required this.metaIndicadorDB})
      : super(MetasIndicadoresInitial()) {
    getMetasIndicadoresDB();
  }

  void getMetasIndicadoresDB() async {
    final result = await metaIndicadorDB.getMetasIndicadoresUsecaseDB();
    result.fold(
        (failure) => emit(MetasIndicadoresError(failure.properties.first)),
        (data) => emit(MetasIndicadoresLoaded(data)));
  }
}
