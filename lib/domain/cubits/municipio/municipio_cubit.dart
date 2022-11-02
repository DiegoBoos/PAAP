import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/municipio_entity.dart';
import '../../usecases/municipio/municipio_db_usecase.dart';
import '../../usecases/municipio/municipio_usecase.dart';

part '../municipio/municipio_state.dart';

class MunicipioCubit extends Cubit<MunicipioState> {
  final MunicipioUsecase municipio;
  final MunicipioUsecaseDB municipioDB;

  MunicipioCubit({required this.municipio, required this.municipioDB})
      : super(MunicipioInitial()) {
    getMunicipioDB();
  }

  void getMunicipioDB() async {
    final result = await municipioDB.getMunicipiosUsecaseDB();
    result.fold((failure) => emit(MunicipioError(failure.properties.first)),
        (data) => emit(MunicipioLoaded(data)));
  }
}
