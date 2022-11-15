import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_beneficiario_entity.dart';
import '../../usecases/perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_db_usecase.dart';

part '../perfil_preinversion_beneficiario/perfil_preinversion_beneficiario_state.dart';

class PerfilPreInversionBeneficiarioCubit
    extends Cubit<PerfilPreInversionBeneficiarioState> {
  final PerfilPreInversionBeneficiarioUsecaseDB
      perfilPreInversionBeneficiarioDB;

  PerfilPreInversionBeneficiarioCubit(
      {required this.perfilPreInversionBeneficiarioDB})
      : super(PerfilPreInversionBeneficiarioInitial());

  void getPerfilPreInversionBeneficiarioDB(String id) async {
    final result = await perfilPreInversionBeneficiarioDB
        .getPerfilPreInversionBeneficiarioUsecaseDB(id);
    result.fold(
        (failure) =>
            emit(PerfilPreInversionBeneficiarioError(failure.properties.first)),
        (data) => emit(PerfilPreInversionBeneficiarioLoaded(data)));
  }
}
