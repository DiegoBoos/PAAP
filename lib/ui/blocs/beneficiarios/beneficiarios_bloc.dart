import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/beneficiario_entity.dart';
import '../../../domain/usecases/beneficiario/beneficiario_db_usecase.dart';

part 'beneficiarios_event.dart';
part 'beneficiarios_state.dart';

class BeneficiariosBloc extends Bloc<BeneficiariosEvent, BeneficiariosState> {
  final BeneficiarioUsecaseDB beneficiarioUsecaseDB;
  BeneficiariosBloc({required this.beneficiarioUsecaseDB})
      : super(BeneficiariosInitial()) {
    on(<InitState>(event, emit) async {
      emit(BeneficiariosInitial());
    });

    on<GetBeneficiarios>((event, emit) async {
      emit(BeneficiariosLoading());
      await _getBeneficiarios(event, emit);
    });
  }

  _getBeneficiarios(event, emit) async {
    final result =
        await beneficiarioUsecaseDB.getBeneficiariosUsecaseDB(event.perfilId);
    result.fold((failure) => emit(BeneficiariosError(failure.properties.first)),
        (data) => emit(BeneficiariosLoaded(data!)));
  }
}
