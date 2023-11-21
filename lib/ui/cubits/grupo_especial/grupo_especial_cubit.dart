import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/grupo_especial_entity.dart';
import '../../../domain/usecases/grupo_especial/grupo_especial_db_usecase.dart';

part '../grupo_especial/grupo_especial_state.dart';

class GrupoEspecialCubit extends Cubit<GrupoEspecialState> {
  final GrupoEspecialUsecaseDB grupoEspecialDB;

  GrupoEspecialCubit({required this.grupoEspecialDB})
      : super(GruposEspecialesInitial()) {
    getGruposEspecialesDB();
  }

  void getGruposEspecialesDB() async {
    final result = await grupoEspecialDB.getGruposEspecialesUsecaseDB();
    result.fold(
        (failure) => emit(GruposEspecialesError(failure.properties.first)),
        (data) => emit(GruposEspecialesLoaded(data)));
  }
}
