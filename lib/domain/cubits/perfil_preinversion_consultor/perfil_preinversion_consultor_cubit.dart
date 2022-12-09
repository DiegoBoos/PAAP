import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_consultor_entity.dart';
import '../../usecases/perfil_preinversion_consultor/perfil_preinversion_consultor_db_usecase.dart';

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

  Future<void> savePerfilPreInversionConsultorDB(
      PerfilPreInversionConsultorEntity
          perfilPreInversionConsultorEntity) async {
    final result = await perfilPreInversionConsultorDB
        .savePerfilPreInversionConsultorUsecaseDB(
            perfilPreInversionConsultorEntity);
    result.fold(
        (failure) =>
            emit(PerfilPreInversionConsultorError(failure.properties.first)),
        (data) => emit(PerfilPreInversionConsultorSaved()));
  }
}
