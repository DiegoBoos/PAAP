import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/perfil_preinversion_aliado_entity.dart';
import '../../../domain/usecases/perfil_preinversion_aliado/perfil_preinversion_aliado_db_usecase.dart';

part 'perfil_preinversion_aliado_state.dart';

class PerfilPreInversionAliadoCubit
    extends Cubit<PerfilPreInversionAliadoState> {
  final PerfilPreInversionAliadoUsecaseDB perfilPreInversionAliadoDB;
  PerfilPreInversionAliadoCubit({required this.perfilPreInversionAliadoDB})
      : super(PerfilPreInversionAliadoInitial());

  void initState() => emit(PerfilPreInversionAliadoInitial());

  void selectAliadoPreinversion(
      PerfilPreInversionAliadoEntity perfilPreInversionAliado) {
    emit(PerfilPreInversionAliadoLoaded(perfilPreInversionAliado));
  }

  void savePerfilPreInversionAliadoDB(
      PerfilPreInversionAliadoEntity perfilPreInversionAliadoEntity) async {
    final result = await perfilPreInversionAliadoDB
        .savePerfilPreInversionAliadoUsecaseDB(perfilPreInversionAliadoEntity);
    result.fold(
        (failure) =>
            emit(PerfilPreInversionAliadoError(failure.properties.first)),
        (data) => emit(PerfilPreInversionAliadoSaved(
            perfilPreInversionAliado: perfilPreInversionAliadoEntity)));
  }

  void changePerfilPreInversionId(String value) {
    final perfilPreInversionId =
        state.perfilPreInversionAliado.copyWith(perfilPreInversionId: value);
    emit(PerfilPreInversionAliadoChanged(perfilPreInversionId));
  }

  void changeProducto(String? value) {
    final productoChanged =
        state.perfilPreInversionAliado.copyWith(productoId: value);
    emit(PerfilPreInversionAliadoChanged(productoChanged));
  }

  void changeUnidad(String? value) {
    final unidadChanged =
        state.perfilPreInversionAliado.copyWith(unidadId: value);
    emit(PerfilPreInversionAliadoChanged(unidadChanged));
  }

  void changeFrecuencia(String? value) {
    final frecuenciaChanged =
        state.perfilPreInversionAliado.copyWith(frecuenciaId: value);
    emit(PerfilPreInversionAliadoChanged(frecuenciaChanged));
  }

  void changeSitioEntrega(String? value) {
    final sitioEntregaChanged =
        state.perfilPreInversionAliado.copyWith(sitioEntregaId: value);
    emit(PerfilPreInversionAliadoChanged(sitioEntregaChanged));
  }

  void changeVolumenCompra(String? newValue) {
    final volumenCompraChanged =
        state.perfilPreInversionAliado.copyWith(volumenCompra: newValue);
    emit(PerfilPreInversionAliadoChanged(volumenCompraChanged));
  }

  void changePorcentajeCompra(String? newValue) {
    final porcentajeCompraChanged =
        state.perfilPreInversionAliado.copyWith(porcentajeCompra: newValue);
    emit(PerfilPreInversionAliadoChanged(porcentajeCompraChanged));
  }

  void changeAliadoId(String? newValue) {
    final aliadoIdChanged =
        state.perfilPreInversionAliado.copyWith(aliadoId: newValue);
    emit(PerfilPreInversionAliadoChanged(aliadoIdChanged));
  }
}
