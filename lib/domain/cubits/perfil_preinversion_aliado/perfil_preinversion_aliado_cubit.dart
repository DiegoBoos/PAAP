import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_aliado_entity.dart';

part 'perfil_preinversion_aliado_state.dart';

class PerfilPreInversionAliadoCubit
    extends Cubit<PerfilPreInversionAliadoState> {
  PerfilPreInversionAliadoCubit() : super(PerfilPreInversionAliadoInitial());
}
