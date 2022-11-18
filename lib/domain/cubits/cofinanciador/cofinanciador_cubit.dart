import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/cofinanciador_entity.dart';
import '../../usecases/cofinanciador/cofinanciador_db_usecase.dart';

part 'cofinanciador_state.dart';

class CofinanciadorCubit extends Cubit<CofinanciadorState> {
  final CofinanciadorUsecaseDB cofinanciadorDB;

  CofinanciadorCubit({required this.cofinanciadorDB})
      : super(CofinanciadoresInitial()) {
    getCofinanciadores();
  }

  void getCofinanciadores() async {
    final result = await cofinanciadorDB.getCofinanciadoresUsecaseDB();
    result.fold((failure) => emit(CofinanciadorError(failure.properties.first)),
        (data) => emit(CofinanciadoresLoaded(data)));
  }
}
