import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/beneficiario_preinversion_entity.dart';
import '../../usecases/beneficiario_preinversion/beneficiario_preinversion_db_usecase.dart';

part 'beneficiarios_preinversion_event.dart';
part 'beneficiarios_preinversion_state.dart';

class BeneficiariosPreinversionBloc extends Bloc<BeneficiariosPreinversionEvent,
    BeneficiariosPreinversionState> {
  final BeneficiarioPreinversionUsecaseDB beneficiarioPreinversionUsecaseDB;
  BeneficiariosPreinversionBloc(
      {required this.beneficiarioPreinversionUsecaseDB})
      : super(BeneficiariosPreinversionInitial()) {
    on<GetBeneficiariosPreinversion>((event, emit) async {
      emit(BeneficiariosPreinversionLoading());
      await _getBeneficiariosPreinversion(event, emit);
    });
  }

  _getBeneficiariosPreinversion(event, emit) async {
    final result = await beneficiarioPreinversionUsecaseDB
        .getBeneficiariosPreinversionsUsecaseDB();
    result.fold(
        (failure) =>
            emit(BeneficiariosPreinversionError(failure.properties.first)),
        (data) => emit(BeneficiariosPreinversionLoaded(
            beneficiariosPreinversionLoaded: data)));
  }
}
