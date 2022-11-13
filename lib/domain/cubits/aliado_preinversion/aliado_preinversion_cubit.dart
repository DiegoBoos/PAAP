import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/aliado_preinversion_entity.dart';

part 'aliado_preinversion_state.dart';

class AliadoPreinversionCubit extends Cubit<AliadoPreinversionState> {
  AliadoPreinversionCubit() : super(AliadoPreinversionInitial());
}
