import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/beneficiario_entity.dart';
import '../../usecases/beneficiario/beneficiario_db_usecase.dart';
import '../../usecases/beneficiario/beneficiario_usecase.dart';

part '../beneficiario/beneficiario_state.dart';

class BeneficiarioCubit extends Cubit<BeneficiarioState> {
  final BeneficiarioUsecase beneficiario;
  final BeneficiarioUsecaseDB beneficiarioDB;

  BeneficiarioCubit({required this.beneficiario, required this.beneficiarioDB})
      : super(BeneficiarioInitial()) {
    getBeneficiarioDB();
  }

  void getBeneficiarioDB() async {
    final result = await beneficiarioDB.getBeneficiariosUsecaseDB();
    result.fold((failure) => emit(BeneficiarioError(failure.properties.first)),
        (data) => emit(BeneficiarioLoaded(data)));
  }
}
