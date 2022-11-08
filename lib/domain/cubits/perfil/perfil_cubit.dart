import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/v_perfil_entity.dart';
import '../../usecases/perfiles/perfiles_db_usecase.dart';

part 'perfil_state.dart';

class PerfilCubit extends Cubit<PerfilState> {
  final PerfilesUsecaseDB perfilDB;

  PerfilCubit({required this.perfilDB}) : super(PerfilInitial());

  void getPerfilDB(String id) async {
    final result = await perfilDB.getPerfilUsecaseDB(id);
    result.fold((failure) => emit(PerfilError(failure.properties.first)),
        (data) => emit(PerfilLoaded(data)));
  }
}
