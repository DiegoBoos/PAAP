import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/beneficiario_entity.dart';
import '../../usecases/beneficiario/beneficiario_db_usecase.dart';

part '../beneficiario/beneficiario_state.dart';

class BeneficiarioCubit extends Cubit<BeneficiarioState> {
  final BeneficiarioUsecaseDB beneficiarioDB;

  BeneficiarioCubit({required this.beneficiarioDB})
      : super(BeneficiarioInitial());

  void getBeneficiarioDB(String id) async {
    final result = await beneficiarioDB.getBeneficiarioUsecaseDB(id);
    result.fold((failure) => emit(BeneficiarioError(failure.properties.first)),
        (data) => emit(BeneficiarioLoaded(data)));
  }
}
