import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_cofinanciador_entity.dart';
import '../../usecases/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_db_usecase.dart';

part '../perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_state.dart';

class PerfilPreInversionCofinanciadorCubit
    extends Cubit<PerfilPreInversionCofinanciadorState> {
  final PerfilPreInversionCofinanciadorUsecaseDB
      perfilPreInversionCofinanciadorDB;

  PerfilPreInversionCofinanciadorCubit(
      {required this.perfilPreInversionCofinanciadorDB})
      : super(PerfilPreInversionCofinanciadorInitial());

  void getPerfilPreInversionCofinanciadorDB(String id) async {
    final result = await perfilPreInversionCofinanciadorDB
        .getPerfilPreInversionCofinanciadorUsecaseDB(id);
    result.fold(
        (failure) => emit(
            PerfilPreInversionCofinanciadorError(failure.properties.first)),
        (data) => emit(PerfilPreInversionCofinanciadorLoaded(data)));
  }
}
