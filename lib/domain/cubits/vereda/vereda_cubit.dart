import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/vereda_entity.dart';
import '../../usecases/vereda/vereda_db_usecase.dart';

part '../vereda/vereda_state.dart';

class VeredaCubit extends Cubit<VeredaState> {
  final VeredaUsecaseDB veredaDB;

  VeredaCubit({required this.veredaDB}) : super(VeredasInitial()) {
    getVeredasDB();
  }

  void getVeredasDB() async {
    final result = await veredaDB.getVeredasUsecaseDB();
    result.fold((failure) => emit(VeredasError(failure.properties.first)),
        (data) => emit(VeredasLoaded(data)));
  }
}
