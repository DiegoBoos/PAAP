import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/sitio_entrega_entity.dart';
import '../../usecases/sitio_entrega/sitio_entrega_db_usecase.dart';

part '../sitio_entrega/sitio_entrega_state.dart';

class SitioEntregaCubit extends Cubit<SitioEntregaState> {
  final SitioEntregaUsecaseDB sitioEntregaDB;

  SitioEntregaCubit({required this.sitioEntregaDB})
      : super(SitiosEntregasInitial()) {
    getSitiosEntregasDB();
  }

  void getSitiosEntregasDB() async {
    final result = await sitioEntregaDB.getSitiosEntregasUsecaseDB();
    result.fold(
        (failure) => emit(SitiosEntregasError(failure.properties.first)),
        (data) => emit(SitiosEntregasLoaded(data)));
  }
}
