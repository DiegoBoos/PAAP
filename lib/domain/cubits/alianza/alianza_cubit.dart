import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/v_alianza_entity.dart';
import '../../usecases/alianza/alianza_db_usecase.dart';

part '../alianza/alianza_state.dart';

class AlianzaCubit extends Cubit<AlianzaState> {
  final AlianzaUsecaseDB alianzaDB;

  AlianzaCubit({required this.alianzaDB}) : super(AlianzaInitial());

  void getAlianzaDB(String id) async {
    final result = await alianzaDB.getAlianzaUsecaseDB(id);
    result.fold((failure) => emit(AlianzaError(failure.properties.first)),
        (data) => emit(AlianzaLoaded(data)));
  }
}
