import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/beneficiario_preinversion_entity.dart';
import '../../usecases/beneficiario_preinversion/beneficiario_preinversion_db_usecase.dart';

part '../beneficiario_preinversion/beneficiario_preinversion_state.dart';

class BeneficiarioPreinversionCubit
    extends Cubit<BeneficiarioPreinversionState> {
  final BeneficiarioPreinversionUsecaseDB beneficiarioPreinversionDB;

  BeneficiarioPreinversionCubit({required this.beneficiarioPreinversionDB})
      : super(BeneficiarioPreinversionInitial());

  void getBeneficiarioPreinversionDB(String id) async {
    final result = await beneficiarioPreinversionDB
        .getBeneficiarioPreinversionUsecaseDB(id);
    result.fold(
        (failure) =>
            emit(BeneficiarioPreinversionError(failure.properties.first)),
        (data) => emit(BeneficiarioPreinversionLoaded(data)));
  }
}
