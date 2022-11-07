import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/alianza_entity.dart';
import '../../usecases/alianza/alianza_db_usecase.dart';
import '../../usecases/alianza/alianza_usecase.dart';

part '../alianza/alianza_state.dart';

class AlianzaCubit extends Cubit<AlianzaState> {
  final AlianzaUsecase alianza;
  final AlianzaUsecaseDB alianzaDB;

  AlianzaCubit({required this.alianza, required this.alianzaDB})
      : super(AlianzaInitial()) {
    getAlianzaDB();
  }

  void getAlianzaDB() async {
    final result = await alianzaDB.getAlianzasUsecaseDB();
    result.fold((failure) => emit(AlianzaError(failure.properties.first)),
        (data) => emit(AlianzaLoaded(data)));
  }
}
