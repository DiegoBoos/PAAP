import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/beneficiario_alianza_entity.dart';
import '../../usecases/beneficiario_alianza/beneficiario_alianza_db_usecase.dart';

part 'beneficiarios_alianza_event.dart';
part 'beneficiarios_alianza_state.dart';

class BeneficiariosAlianzaBloc
    extends Bloc<BeneficiariosAlianzaEvent, BeneficiariosAlianzaState> {
  final BeneficiarioAlianzaUsecaseDB beneficiarioAlianzaUsecaseDB;
  BeneficiariosAlianzaBloc({required this.beneficiarioAlianzaUsecaseDB})
      : super(BeneficiariosAlianzaInitial()) {
    on<GetBeneficiariosAlianza>((event, emit) async {
      emit(BeneficiariosAlianzaLoading());
      await _getBeneficiariosAlianza(event, emit);
    });
  }

  _getBeneficiariosAlianza(event, emit) async {
    final result =
        await beneficiarioAlianzaUsecaseDB.getBeneficiariosAlianzaUsecaseDB();
    result.fold(
        (failure) => emit(BeneficiariosAlianzaError(failure.properties.first)),
        (data) =>
            emit(BeneficiariosAlianzaLoaded(beneficiariosAlianzaLoaded: data)));
  }
}
