import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/municipio_entity.dart';
import '../../../domain/usecases/municipio/municipio_db_usecase.dart';

part '../municipio/municipio_state.dart';

class MunicipioCubit extends Cubit<MunicipioState> {
  final MunicipioUsecaseDB municipioDB;

  MunicipioCubit({required this.municipioDB}) : super(MunicipiosInitial());

  void initState() => emit(MunicipiosInitial());

  void getMunicipiosDB() async {
    final result = await municipioDB.getMunicipiosUsecaseDB();
    result.fold((failure) => emit(MunicipiosError(failure.properties.first)),
        (data) => emit(MunicipiosLoaded(data)));
  }
}
