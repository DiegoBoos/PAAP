import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/aliado_entity.dart';
import '../../entities/aliado_preinversion_entity.dart';

part '../aliado/aliado_state.dart';

class AliadoCubit extends Cubit<AliadoState> {
  AliadoCubit() : super(AliadoInitial());

  void selectAliado(AliadoPreinversionEntity aliadoPreinversionEntity) {
    final currentState = state;
    if (currentState is AliadoLoaded) {}
  }
}
