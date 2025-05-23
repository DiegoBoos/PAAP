import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/perfil_preinversion_consultor_entity.dart';
import '../../../domain/usecases/perfil_preinversion_consultor/perfil_preinversion_consultor_db_usecase.dart';

part '../perfil_preinversion_consultor/perfil_preinversion_consultor_state.dart';

class PerfilPreInversionConsultorCubit
    extends Cubit<PerfilPreInversionConsultorState> {
  final PerfilPreInversionConsultorUsecaseDB perfilPreInversionConsultorDB;

  PerfilPreInversionConsultorCubit(
      {required this.perfilPreInversionConsultorDB})
      : super(PerfilPreInversionConsultorInitial());

  void getPerfilPreInversionConsultorDB(String perfilPreInversionId,
      String consultorId, String revisionId) async {
    final result = await perfilPreInversionConsultorDB
        .getPerfilPreInversionConsultorUsecaseDB(
            perfilPreInversionId, consultorId, revisionId);
    result.fold(
        (failure) =>
            emit(PerfilPreInversionConsultorError(failure.properties.first)),
        (data) {
      if (data != null) {
        emit(PerfilPreInversionConsultorLoaded(data));
      } else {
        emit(PerfilPreInversionConsultorInitial());
      }
    });
  }

  void savePerfilPreInversionConsultorDB(
      PerfilPreInversionConsultorEntity perfilPreInversionConsultor) async {
    final result = await perfilPreInversionConsultorDB
        .savePerfilPreInversionConsultorUsecaseDB(perfilPreInversionConsultor);
    result.fold(
        (failure) =>
            emit(PerfilPreInversionConsultorError(failure.properties.first)),
        (data) => emit(PerfilPreInversionConsultorSaved()));
  }
}
