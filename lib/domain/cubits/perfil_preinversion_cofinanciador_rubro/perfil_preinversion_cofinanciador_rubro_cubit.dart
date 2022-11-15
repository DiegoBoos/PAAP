import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_cofinanciador_rubro_entity.dart';
import '../../usecases/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_db_usecase.dart';

part 'perfil_preinversion_cofinanciador_rubro_state.dart';

class PerfilPreInversionCofinanciadorRubroCubit
    extends Cubit<PerfilPreInversionCofinanciadorRubroState> {
  final PerfilPreInversionCofinanciadorRubroUsecaseDB
      perfilPreInversionCofinanciadorRubroDB;

  PerfilPreInversionCofinanciadorRubroCubit(
      {required this.perfilPreInversionCofinanciadorRubroDB})
      : super(PerfilPreInversionCofinanciadorRubrosInitial());

  void getPerfilPreInversionCofinanciadorRubrosDB() async {
    final result = await perfilPreInversionCofinanciadorRubroDB
        .getPerfilPreInversionCofinanciadorRubrosUsecaseDB();
    result.fold(
        (failure) => emit(PerfilPreInversionCofinanciadorRubrosError(
            failure.properties.first)),
        (data) => emit(PerfilPreInversionCofinanciadorRubrosLoaded(data)));
  }

  void initState() => emit(PerfilPreInversionCofinanciadorRubrosInitial());
}
