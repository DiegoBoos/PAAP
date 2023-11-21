import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/cofinanciador_entity.dart';
import '../../../domain/usecases/cofinanciador/cofinanciador_db_usecase.dart';

part 'cofinanciador_state.dart';

class CofinanciadorCubit extends Cubit<CofinanciadorState> {
  final CofinanciadorUsecaseDB cofinanciadorDB;

  CofinanciadorCubit({required this.cofinanciadorDB})
      : super(CofinanciadoresInitial());

  Future<void> getCofinanciadores() async {
    final result = await cofinanciadorDB.getCofinanciadoresUsecaseDB();
    result.fold((failure) => emit(CofinanciadorError(failure.properties.first)),
        (data) => emit(CofinanciadoresLoaded(data!)));
  }
}
