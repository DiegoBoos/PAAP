import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/aliado_entity.dart';
import '../../usecases/aliado/aliado_db_usecase.dart';
part '../aliado/aliado_state.dart';

class AliadoCubit extends Cubit<AliadoState> {
  final AliadoUsecaseDB aliadoUsecaseDB;

  AliadoCubit({required this.aliadoUsecaseDB}) : super(AliadoInitial());

  void initState() => emit(AliadoInitial());

  Future<void> selectAliado(String aliadoId) async {
    final result = await aliadoUsecaseDB.getAliadoUsecaseDB(aliadoId);
    result.fold((failure) => emit(AliadoError(failure.properties.first)),
        (data) {
      if (data == null) {
        emit(const AliadoError('No se encontró el aliado'));
      } else {
        emit(AliadoLoaded(data));
      }
    });
  }

  void changeExperiencia(String? newValue) {}

  void changeNombreContacto(String? newValue) {}

  void changeDireccion(String? newValue) {}

  void changeCorreo(String? newValue) {}

  void changeTelefonoFijo(String? newValue) {}

  void changeTelefonoMovil(String? newValue) {}

  void changeFechaDesactivacion(String? newValue) {}

  void changeVolumenCompra(String? newValue) {}

  void changePorcentajeCompra(String? newValue) {}
}
