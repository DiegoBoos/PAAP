import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_cofinanciador_desembolso_entity.dart';
import '../../usecases/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_db_usecase.dart';

part 'perfil_preinversion_cofinanciador_desembolso_state.dart';

class PerfilPreInversionCofinanciadorDesembolsoCubit
    extends Cubit<PerfilPreInversionCofinanciadorDesembolsoState> {
  final PerfilPreInversionCofinanciadorDesembolsoUsecaseDB
      perfilPreInversionCofinanciadorDesembolsoDB;

  PerfilPreInversionCofinanciadorDesembolsoCubit(
      {required this.perfilPreInversionCofinanciadorDesembolsoDB})
      : super(PerfilPreInversionCofinanciadorDesembolsosInitial());

  void getPerfilPreInversionCofinanciadorDesembolsosDB() async {
    final result = await perfilPreInversionCofinanciadorDesembolsoDB
        .getPerfilPreInversionCofinanciadorDesembolsosUsecaseDB();
    result.fold(
        (failure) => emit(PerfilPreInversionCofinanciadorDesembolsosError(
            failure.properties.first)),
        (data) => emit(PerfilPreInversionCofinanciadorDesembolsosLoaded(data)));
  }

  void initState() => emit(PerfilPreInversionCofinanciadorDesembolsosInitial());
}
