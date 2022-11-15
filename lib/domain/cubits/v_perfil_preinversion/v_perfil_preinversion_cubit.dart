import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/v_perfil_preinversion_entity.dart';

part 'v_perfil_preinversion_state.dart';

class VPerfilPreInversionCubit extends Cubit<VPerfilPreInversionState> {
  VPerfilPreInversionCubit() : super(VPerfilPreInversionInitial());

  void selectVPerfilPreinversion(
      VPerfilPreInversionEntity vPerfilPreInversionEntity) {
    emit(VPerfilPreInversionSelected(vPerfilPreInversionEntity));
  }
}
