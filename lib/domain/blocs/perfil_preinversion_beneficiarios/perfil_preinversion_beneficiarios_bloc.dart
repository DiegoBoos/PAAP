import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_beneficiario_entity.dart';
import '../../usecases/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_db_usecase.dart';

part 'perfil_preinversion_beneficiarios_event.dart';
part 'perfil_preinversion_beneficiarios_state.dart';

class PerfilPreInversionBeneficiariosBloc extends Bloc<
    PerfilPreInversionBeneficiariosEvent, PerfilPreInversionBeneficiariostate> {
  final PerfilPreInversionBeneficiarioUsecaseDB
      perfilPreInversionBeneficiarioUsecaseDB;
  PerfilPreInversionBeneficiariosBloc(
      {required this.perfilPreInversionBeneficiarioUsecaseDB})
      : super(PerfilPreInversionBeneficiariosInitial()) {
    on<GetPerfilPreInversionBeneficiarios>((event, emit) async {
      emit(PerfilPreInversionBeneficiariosLoading());
      await _getPerfilPreInversionBeneficiarios(event, emit);
    });
  }

  _getPerfilPreInversionBeneficiarios(event, emit) async {
    final result = await perfilPreInversionBeneficiarioUsecaseDB
        .getPerfilPreInversionBeneficiariosUsecaseDB();
    result.fold(
        (failure) => emit(
            PerfilPreInversionBeneficiariosError(failure.properties.first)),
        (data) => emit(PerfilPreInversionBeneficiariosLoaded(
            perfilPreInversionBeneficiariosLoaded: data)));
  }
}
