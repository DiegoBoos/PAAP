import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/municipio_entity.dart';
import '../../usecases/municipio/municipio_db_usecase.dart';

part '../municipio/municipio_state.dart';

class MunicipioCubit extends Cubit<MunicipioState> {
  final MunicipioUsecaseDB municipioDB;

  MunicipioCubit({required this.municipioDB})
      : super(const MunicipiosInitial()) {
    getMunicipiosDB();
  }

  Future<void> getMunicipiosDB() async {
    final result = await municipioDB.getMunicipiosUsecaseDB();
    result.fold((failure) => emit(MunicipiosError(failure.properties.first)),
        (data) => emit(MunicipiosLoaded(data)));
  }

  void getMunicipiosByDepartamentoDB(String departamentoId) async {
    final result =
        await municipioDB.getMunicipiosByDepartamentoUsecaseDB(departamentoId);
    result.fold((failure) => emit(MunicipiosError(failure.properties.first)),
        (data) => emit(MunicipiosLoaded(data)));
  }
}
