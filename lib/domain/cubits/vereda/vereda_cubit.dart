import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/vereda_entity.dart';
import '../../usecases/vereda/vereda_db_usecase.dart';

part '../vereda/vereda_state.dart';

class VeredaCubit extends Cubit<VeredaState> {
  final VeredaUsecaseDB veredaDB;

  VeredaCubit({required this.veredaDB}) : super(VeredasInitial());

  Future<void> getVeredasByMunicipioDB(String municipioId) async {
    final result = await veredaDB.getVeredasByMunicipioUsecaseDB(municipioId);
    result.fold((failure) => emit(VeredasError(failure.properties.first)),
        (data) => emit(VeredasLoaded(data)));
  }
}
