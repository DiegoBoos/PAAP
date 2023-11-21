import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/beneficio_entity.dart';
import '../../../domain/usecases/beneficio/beneficio_db_usecase.dart';

part '../beneficio/beneficio_state.dart';

class BeneficioCubit extends Cubit<BeneficioState> {
  final BeneficioUsecaseDB beneficioDB;

  BeneficioCubit({required this.beneficioDB}) : super(BeneficiosInitial()) {
    getBeneficiosDB();
  }

  void getBeneficiosDB() async {
    final result = await beneficioDB.getBeneficiosUsecaseDB();
    result.fold((failure) => emit(BeneficiosError(failure.properties.first)),
        (data) => emit(BeneficiosLoaded(data)));
  }
}
