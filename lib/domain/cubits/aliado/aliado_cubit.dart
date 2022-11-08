import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/aliado_entity.dart';
import '../../usecases/aliado/aliado_db_usecase.dart';

part '../aliado/aliado_state.dart';

class AliadoCubit extends Cubit<AliadoState> {
  final AliadoUsecaseDB aliadoDB;

  AliadoCubit({required this.aliadoDB}) : super(AliadoInitial());

  void getAliadoDB(String id) async {
    final result = await aliadoDB.getAliadoUsecaseDB(id);
    result.fold((failure) => emit(AliadoError(failure.properties.first)),
        (data) => emit(AliadoLoaded(data)));
  }
}
