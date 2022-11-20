import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_precio_entity.dart';
import '../../usecases/perfil_preinversion_precio/perfil_preinversion_precio_db_usecase.dart';

part 'perfil_preinversion_precio_state.dart';

class PerfilPreInversionPrecioCubit
    extends Cubit<PerfilPreInversionPrecioState> {
  final PerfilPreInversionPrecioUsecaseDB perfilPreInversionPrecioDB;

  PerfilPreInversionPrecioCubit({required this.perfilPreInversionPrecioDB})
      : super(PerfilPreInversionPreciosInitial());

  void getPerfilPreInversionPreciosDB() async {
    final result = await perfilPreInversionPrecioDB
        .getPerfilPreInversionPreciosUsecaseDB();
    result.fold(
        (failure) =>
            emit(PerfilPreInversionPrecioError(failure.properties.first)),
        (data) => emit(PerfilPreInversionPreciosLoaded(data)));
  }

  void savePerfilPreInversionPrecioDB(
      PerfilPreInversionPrecioEntity perfilPreInversionPrecioEntity) async {
    final result = await perfilPreInversionPrecioDB
        .savePerfilPreInversionPrecioUsecaseDB(perfilPreInversionPrecioEntity);
    result.fold(
        (failure) =>
            emit(PerfilPreInversionPrecioError(failure.properties.first)),
        (data) => emit(PerfilPreInversionPrecioSaved()));
  }

  void initState() => emit(PerfilPreInversionPreciosInitial());
}
