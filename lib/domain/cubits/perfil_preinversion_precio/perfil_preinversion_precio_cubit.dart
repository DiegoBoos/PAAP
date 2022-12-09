import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/perfil_preinversion_precio_entity.dart';
import '../../usecases/perfil_preinversion_precio/perfil_preinversion_precio_db_usecase.dart';

part 'perfil_preinversion_precio_state.dart';

class PerfilPreInversionPrecioCubit
    extends Cubit<PerfilPreInversionPrecioState> {
  final PerfilPreInversionPrecioUsecaseDB perfilPreInversionPrecioDB;

  PerfilPreInversionPrecioCubit({required this.perfilPreInversionPrecioDB})
      : super(PerfilPreInversionPrecioInitial());

  void initState() => emit(PerfilPreInversionPrecioInitial());

  void getPerfilPreInversionPrecioCubit(String perfilPreInversionId) async {
    final result = await perfilPreInversionPrecioDB
        .getPerfilPreInversionPrecioUsecaseDB(perfilPreInversionId);
    result.fold(
        (failure) =>
            emit(PerfilPreInversionPrecioError(failure.properties.first)),
        (data) => emit(PerfilPreInversionPrecioLoaded(data!)));
  }

  Future<void> savePerfilPreInversionPrecioDB(
      PerfilPreInversionPrecioEntity perfilPreInversionPrecioEntity) async {
    final result = await perfilPreInversionPrecioDB
        .savePerfilPreInversionPrecioUsecaseDB(perfilPreInversionPrecioEntity);
    result.fold(
        (failure) =>
            emit(PerfilPreInversionPrecioError(failure.properties.first)),
        (data) => emit(PerfilPreInversionPrecioSaved(
            perfilPreInversionPrecio: perfilPreInversionPrecioEntity)));
  }

  void changePerfilPreInversionId(String perfilPreInversionId) {
    final perfilPreInversionIdChanged = state.perfilPreInversionPrecio
        .copyWith(perfilPreInversionId: perfilPreInversionId);
    emit(PerfilPreInversionPrecioChanged(perfilPreInversionIdChanged));
  }

  void changeTipoCalidad(String? value) {
    final tipoCalidad =
        state.perfilPreInversionPrecio.copyWith(tipoCalidadId: value);
    emit(PerfilPreInversionPrecioChanged(tipoCalidad));
  }

  void changeProducto(String? value) {
    final productoChanged =
        state.perfilPreInversionPrecio.copyWith(productoId: value);
    emit(PerfilPreInversionPrecioChanged(productoChanged));
  }

  void changeUnidad(String? value) {
    final unidadChanged =
        state.perfilPreInversionPrecio.copyWith(unidadId: value);
    emit(PerfilPreInversionPrecioChanged(unidadChanged));
  }

  void changePrecio(String? newValue) {
    final precioChanged =
        state.perfilPreInversionPrecio.copyWith(precio: newValue);
    emit(PerfilPreInversionPrecioChanged(precioChanged));
  }
}
