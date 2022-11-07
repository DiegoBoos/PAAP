import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/aliado_entity.dart';
import '../../usecases/aliado/aliado_db_usecase.dart';
import '../../usecases/aliado/aliado_usecase.dart';

part '../aliado/aliado_state.dart';

class AliadoCubit extends Cubit<AliadoState> {
  final AliadoUsecase aliado;
  final AliadoUsecaseDB aliadoDB;

  AliadoCubit({required this.aliado, required this.aliadoDB})
      : super(AliadoInitial()) {
    getAliadoDB();
  }

  void getAliadoDB() async {
    final result = await aliadoDB.getAliadosUsecaseDB();
    result.fold((failure) => emit(AliadoError(failure.properties.first)),
        (data) => emit(AliadoLoaded(data)));
  }
}
