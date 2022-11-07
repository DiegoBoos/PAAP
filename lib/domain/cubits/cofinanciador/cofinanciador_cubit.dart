import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/cofinanciador_entity.dart';
import '../../usecases/cofinanciador/cofinanciador_db_usecase.dart';
import '../../usecases/cofinanciador/cofinanciador_usecase.dart';

part 'cofinanciador_state.dart';

class CofinanciadorCubit extends Cubit<CofinanciadorState> {
  final CofinanciadorUsecase cofinanciador;
  final CofinanciadorUsecaseDB cofinanciadorDB;

  CofinanciadorCubit(
      {required this.cofinanciador, required this.cofinanciadorDB})
      : super(CofinanciadorInitial()) {
    getCofinanciadorDB();
  }

  void getCofinanciadorDB() async {
    final result = await cofinanciadorDB.getCofinanciadoresUsecaseDB();
    result.fold((failure) => emit(CofinanciadorError(failure.properties.first)),
        (data) => emit(CofinanciadorLoaded(data)));
  }
}
