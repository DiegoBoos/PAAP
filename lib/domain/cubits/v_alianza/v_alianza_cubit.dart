import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/v_alianza_entity.dart';

part 'v_alianza_state.dart';

class VAlianzaCubit extends Cubit<VAlianzaState> {
  VAlianzaCubit() : super(VAlianzaInitial());

  void selectVPerfilPreinversion(VAlianzaEntity vAlianzaEntity) {
    emit(VAlianzaSelected(vAlianzaEntity));
  }
}
