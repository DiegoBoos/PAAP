import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/vereda_entity.dart';
import '../../usecases/vereda/vereda_db_usecase.dart';
import '../../usecases/vereda/vereda_usecase.dart';

part '../vereda/vereda_state.dart';

class VeredaCubit extends Cubit<VeredaState> {
  final VeredaUsecase vereda;
  final VeredaUsecaseDB veredaDB;

  VeredaCubit({required this.vereda, required this.veredaDB})
      : super(VeredaInitial()) {
    getVeredaDB();
  }

  void getVeredaDB() async {
    final result = await veredaDB.getVeredasUsecaseDB();
    result.fold((failure) => emit(VeredaError(failure.properties.first)),
        (data) => emit(VeredaLoaded(data)));
  }
}
