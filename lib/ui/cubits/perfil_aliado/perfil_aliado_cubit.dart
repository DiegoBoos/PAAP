import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/perfil_aliado_entity.dart';
import '../../../domain/usecases/perfil_aliado/perfil_aliado_db_usecase.dart';

part 'perfil_aliado_state.dart';

class PerfilAliadoCubit extends Cubit<PerfilAliadoState> {
  final PerfilAliadoUsecaseDB perfilAliadoDB;
  PerfilAliadoCubit({required this.perfilAliadoDB})
      : super(PerfilAliadoInitial());

  void initState() => emit(PerfilAliadoInitial());

  void savePerfilAliadoDB(PerfilAliadoEntity perfilAliadoEntity) async {
    final result =
        await perfilAliadoDB.savePerfilAliadoUsecaseDB(perfilAliadoEntity);
    result.fold((failure) => emit(PerfilAliadoError(failure.properties.first)),
        (data) => emit(PerfilAliadoSaved(perfilAliado: perfilAliadoEntity)));
  }

  void changePerfilId(String value) {
    final perfilId = state.perfilAliado.copyWith(perfilId: value);
    emit(PerfilAliadoChanged(perfilId));
  }

  void changeProducto(String? value) {
    final productoChanged = state.perfilAliado.copyWith(productoId: value);
    emit(PerfilAliadoChanged(productoChanged));
  }

  void changeUnidad(String? value) {
    final unidadChanged = state.perfilAliado.copyWith(unidadId: value);
    emit(PerfilAliadoChanged(unidadChanged));
  }

  void changeFrecuencia(String? value) {
    final frecuenciaChanged = state.perfilAliado.copyWith(frecuenciaId: value);
    emit(PerfilAliadoChanged(frecuenciaChanged));
  }

  void changeSitioEntrega(String? value) {
    final sitioEntregaChanged =
        state.perfilAliado.copyWith(sitioEntregaId: value);
    emit(PerfilAliadoChanged(sitioEntregaChanged));
  }

  void changeVolumenCompra(String? newValue) {
    final volumenCompraChanged =
        state.perfilAliado.copyWith(volumenCompra: newValue);
    emit(PerfilAliadoChanged(volumenCompraChanged));
  }

  void changePorcentajeCompra(String? newValue) {
    final porcentajeCompraChanged =
        state.perfilAliado.copyWith(porcentajeCompra: newValue);
    emit(PerfilAliadoChanged(porcentajeCompraChanged));
  }

  void changeAliadoId(String? newValue) {
    final aliadoIdChanged = state.perfilAliado.copyWith(aliadoId: newValue);
    emit(PerfilAliadoChanged(aliadoIdChanged));
  }
}
