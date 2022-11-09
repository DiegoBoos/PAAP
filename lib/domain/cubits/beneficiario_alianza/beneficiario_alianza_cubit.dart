import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/beneficiario_alianza_entity.dart';
import '../../usecases/beneficiario_alianza/beneficiario_alianza_db_usecase.dart';

part '../beneficiario_alianza/beneficiario_alianza_state.dart';

class BeneficiarioAlianzaCubit extends Cubit<BeneficiarioAlianzaState> {
  final BeneficiarioAlianzaUsecaseDB beneficiarioAlianzaDB;

  BeneficiarioAlianzaCubit({required this.beneficiarioAlianzaDB})
      : super(BeneficiarioAlianzaInitial());

  void getBeneficiarioAlianzaDB(String id) async {
    final result =
        await beneficiarioAlianzaDB.getBeneficiarioAlianzaUsecaseDB(id);
    result.fold(
        (failure) => emit(BeneficiarioAlianzaError(failure.properties.first)),
        (data) => emit(BeneficiarioAlianzaLoaded(data)));
  }
}
