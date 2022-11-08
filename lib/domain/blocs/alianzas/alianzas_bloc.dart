import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/alianza_entity.dart';
import '../../usecases/alianza/alianza_db_usecase.dart';

part 'alianzas_event.dart';
part 'alianzas_state.dart';

class AlianzasBloc extends Bloc<AlianzasEvent, AlianzasState> {
  final AlianzaUsecaseDB alianzasDB;

  AlianzasBloc({
    required this.alianzasDB,
  }) : super(AlianzasInitial()) {
    on<GetAlianzas>((event, emit) async {
      emit(AlianzasLoading());
      await _getAlianzas(event, emit);
    });

    on<GetAlianzasFiltros>((event, emit) async {
      emit(AlianzasLoading());
      await _getAlianzasFiltros(event, emit);
    });
  }

  _getAlianzas(event, emit) async {
    final result = await alianzasDB.getAlianzasUsecaseDB();
    result.fold((failure) => emit(AlianzasError(failure.properties.first)),
        (data) => emit(AlianzasLoaded(alianzasLoaded: data)));
  }

  _getAlianzasFiltros(event, emit) async {
    final id = event.id;
    final nombre = event.nombre;

    final result = await alianzasDB.getAlianzasFiltrosUsecaseDB(id, nombre);
    result.fold((failure) {
      emit(AlianzasError(failure.properties.first));
    }, (data) {
      emit(AlianzasLoaded(alianzasLoaded: data));
    });
  }
}
