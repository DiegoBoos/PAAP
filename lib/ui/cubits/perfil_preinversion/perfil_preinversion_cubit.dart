import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/perfil_preinversion_entity.dart';
import '../../../domain/usecases/perfil_preinversion/perfil_preinversion_db_usecase.dart';
part '../perfil_preinversion/perfil_preinversion_state.dart';

class PerfilPreInversionCubit extends Cubit<PerfilPreInversionState> {
  final PerfilPreInversionUsecaseDB perfilPreInversionDB;

  PerfilPreInversionCubit({required this.perfilPreInversionDB})
      : super(PerfilPreInversionInitial());

  void initState() => emit(PerfilPreInversionInitial());

  void getPerfilPreInversionDB(String id) async {
    final result =
        await perfilPreInversionDB.getPerfilPreInversionUsecaseDB(id);
    result.fold(
        (failure) => emit(PerfilPreInversionError(failure.properties.first)),
        (data) {
      if (data != null) {
        emit(PerfilPreInversionLoaded(data));
      }
    });
  }
}
