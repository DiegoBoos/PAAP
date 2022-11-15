import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/v_perfil_entity.dart';

part 'v_perfil_state.dart';

class VPerfilCubit extends Cubit<VPerfilState> {
  VPerfilCubit() : super(VPerfilInitial());

  void selectVPerfil(VPerfilEntity vPerfilEntity) {
    emit(VPerfilSelected(vPerfilEntity));
  }
}
