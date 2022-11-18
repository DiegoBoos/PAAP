import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_aliado_entity.dart';

part 'perfil_preinversion_aliado_state.dart';

class PerfilPreInversionAliadoCubit
    extends Cubit<PerfilPreInversionAliadoState> {
  PerfilPreInversionAliadoCubit() : super(PerfilPreInversionAliadoInitial());

  void initState() => emit(PerfilPreInversionAliadoInitial());

  void selectAliadoPreinversion(
      PerfilPreInversionAliadoEntity perfilPreInversionAliado) {
    emit(PerfilPreInversionAliadoLoaded(perfilPreInversionAliado));
  }

  void changeProducto(String? value) {}

  void changeUnidad(String? value) {}

  void changeFrecuencia(String? value) {}

  void changeSitioEntrega(String? value) {}
}
