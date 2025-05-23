import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/aliado_entity.dart';
import '../../../domain/usecases/aliado/aliado_db_usecase.dart';
part '../aliado/aliado_state.dart';

class AliadoCubit extends Cubit<AliadoState> {
  final AliadoUsecaseDB aliadoUsecaseDB;

  AliadoCubit({required this.aliadoUsecaseDB}) : super(AliadoInitial());

  void initState() => emit(AliadoInitial());

  void setAliado(AliadoEntity aliado) {
    emit(AliadoLoaded(aliado));
  }

  void saveAliadoDB() async {
    final result = await aliadoUsecaseDB.saveAliadoUsecaseDB(state.aliado);
    result.fold((failure) => emit(AliadoError(failure.properties.first)),
        (data) => emit(AliadoSaved(aliadoSaved: state.aliado)));
  }

  void getAliado(String aliadoId) async {
    final result = await aliadoUsecaseDB.getAliadoUsecaseDB(aliadoId);
    result.fold((failure) => emit(AliadoError(failure.properties.first)),
        (data) {
      if (data == null) {
        emit(AliadoError('No se encontró el aliado'));
      } else {
        emit(AliadoLoaded(data));
      }
    });
  }

  void changeAliadoId(String? newValue) {
    final aliadoIdChanged = state.aliado.copyWith(aliadoId: newValue);
    emit(AliadoChanged(aliadoIdChanged));
  }

  void changeNombre(String? newValue) {
    final nombreChanged = state.aliado.copyWith(nombre: newValue);
    emit(AliadoChanged(nombreChanged));
  }

  void changeExperiencia(String? newValue) {
    final experienciaChanged = state.aliado.copyWith(experiencia: newValue);
    emit(AliadoChanged(experienciaChanged));
  }

  void changeNombreContacto(String? newValue) {
    final nombreContactoChanged =
        state.aliado.copyWith(nombreContacto: newValue);
    emit(AliadoChanged(nombreContactoChanged));
  }

  void changeDireccion(String? newValue) {
    final direccionChanged = state.aliado.copyWith(direccion: newValue);
    emit(AliadoChanged(direccionChanged));
  }

  void changeCorreo(String? newValue) {
    final correoChanged = state.aliado.copyWith(correo: newValue);
    emit(AliadoChanged(correoChanged));
  }

  void changeTelefonoFijo(String? newValue) {
    final telefonoFijoChanged = state.aliado.copyWith(telefonoFijo: newValue);
    emit(AliadoChanged(telefonoFijoChanged));
  }

  void changeTelefonoMovil(String? newValue) {
    final telefonoMovilChanged = state.aliado.copyWith(telefonoMovil: newValue);
    emit(AliadoChanged(telefonoMovilChanged));
  }

  void changeFechaDesactivacion(String? newValue) {
    final fechaDesactivacionChanged =
        state.aliado.copyWith(fechaDesactivacion: newValue);
    emit(AliadoChanged(fechaDesactivacionChanged));
  }

  void changeMunicipio(String? newValue) {
    final municipioChanged = state.aliado.copyWith(municipioId: newValue);
    emit(AliadoChanged(municipioChanged));
  }

  void changeFechaCreacion(String? newValue) {
    final fechaCreacionChanged = state.aliado.copyWith(fechaCreacion: newValue);
    emit(AliadoChanged(fechaCreacionChanged));
  }

  void changeFechaActivacion(String? newValue) {
    final fechaActivacionChanged =
        state.aliado.copyWith(fechaActivacion: newValue);
    emit(AliadoChanged(fechaActivacionChanged));
  }

  void changeFechaCambio(String? newValue) {
    final fechaCambioChanged = state.aliado.copyWith(fechaCambio: newValue);
    emit(AliadoChanged(fechaCambioChanged));
  }

  void changeActivo(String newValue) {
    final activoChanged = state.aliado.copyWith(activo: newValue);
    emit(AliadoChanged(activoChanged));
  }
}
