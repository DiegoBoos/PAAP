import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paap/domain/entities/perfil_entity.dart';

import '../../cubits/internet/internet_cubit.dart';
import '../../usecases/perfiles/perfiles_db_usecase.dart';
import '../../usecases/perfiles/perfiles_usecase.dart';

part 'perfiles_event.dart';
part 'perfiles_state.dart';

class PerfilesBloc extends Bloc<PerfilesEvent, PerfilesState> {
  final InternetCubit internetCubit;

  final PerfilesUsecase perfiles;
  final PerfilesUsecaseDB perfilesDB;
  PerfilesBloc(
      {required this.internetCubit,
      required this.perfiles,
      required this.perfilesDB})
      : super(PerfilesInitial()) {
    on<GetPerfiles>((event, emit) async {
      if (event.isOffline) {
        emit(PerfilesLoading());
        await _getPerfilesOffline(event, emit);
      } else {
        emit(PerfilesLoading());
        await _getPerfilesOnline(event, emit);
      }
    });
  }

  _getPerfilesOnline(event, emit) async {
    final usuarioId = event.usuarioId;
    final contrasena = event.contrasena;

    final result = await perfiles.getPerfilesUsecase(usuarioId, contrasena);
    result.fold((failure) {
      emit(PerfilesError(failure.properties.first));
    }, (data) async {
      emit(PerfilesLoaded(data));
      await perfilesDB.savePerfilesDB(data);
    });
  }

  _getPerfilesOffline(event, emit) async {
    final usuarioId = event.usuarioId;
    final contrasena = event.contrasena;

    final result = await perfiles.getPerfilesUsecase(usuarioId, contrasena);
    result.fold((failure) {
      emit(PerfilesError(failure.properties.first));
    }, (data) {
      emit(PerfilesLoaded(data));
    });
  }
}
