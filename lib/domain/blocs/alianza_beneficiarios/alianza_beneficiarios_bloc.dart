import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/alianza_beneficiario_entity.dart';
import '../../usecases/alianza_beneficiario/alianza_beneficiario_db_usecase.dart';

part 'alianza_beneficiarios_event.dart';
part 'alianza_beneficiarios_state.dart';

class AlianzasBeneficiariosBloc
    extends Bloc<AlianzasBeneficiariosEvent, AlianzasBeneficiariostate> {
  final AlianzaBeneficiarioUsecaseDB alianzaBeneficiarioUsecaseDB;
  AlianzasBeneficiariosBloc({required this.alianzaBeneficiarioUsecaseDB})
      : super(AlianzasBeneficiariosInitial()) {
    on<GetAlianzasBeneficiarios>((event, emit) async {
      emit(AlianzasBeneficiariosLoading());
      await _getAlianzasBeneficiarios(event, emit);
    });
  }

  _getAlianzasBeneficiarios(event, emit) async {
    final result =
        await alianzaBeneficiarioUsecaseDB.getAlianzasBeneficiariosUsecaseDB();
    result.fold(
        (failure) => emit(AlianzasBeneficiariosError(failure.properties.first)),
        (data) => emit(
            AlianzasBeneficiariosLoaded(alianzasBeneficiariosLoaded: data)));
  }
}
