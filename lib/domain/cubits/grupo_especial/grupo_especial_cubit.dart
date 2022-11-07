import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/grupo_especial_entity.dart';
import '../../usecases/grupo_especial/grupo_especial_db_usecase.dart';
import '../../usecases/grupo_especial/grupo_especial_usecase.dart';

part '../grupo_especial/grupo_especial_state.dart';

class GrupoEspecialCubit extends Cubit<GrupoEspecialState> {
  final GrupoEspecialUsecase grupoEspecial;
  final GrupoEspecialUsecaseDB grupoEspecialDB;

  GrupoEspecialCubit(
      {required this.grupoEspecial, required this.grupoEspecialDB})
      : super(GrupoEspecialInitial()) {
    getGrupoEspecialDB();
  }

  void getGrupoEspecialDB() async {
    final result = await grupoEspecialDB.getGruposEspecialesUsecaseDB();
    result.fold((failure) => emit(GrupoEspecialError(failure.properties.first)),
        (data) => emit(GrupoEspecialLoaded(data)));
  }
}
