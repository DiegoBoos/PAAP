import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_entity.dart';
import '../../usecases/perfiles/perfiles_db_usecase.dart';
import '../../usecases/perfiles/perfiles_usecase.dart';

part 'perfil_state.dart';

class PerfilCubit extends Cubit<PerfilState> {
  final PerfilesUsecase perfil;
  final PerfilesUsecaseDB perfilDB;

  PerfilCubit({required this.perfil, required this.perfilDB})
      : super(PerfilInitial()) {
    getPerfilDB();
  }

  void getPerfilDB() async {
    final result = await perfilDB.getPerfilesUsecaseDB();
    result.fold((failure) => emit(PerfilError(failure.properties.first)),
        (data) => emit(PerfilLoaded(data)));
  }
}
