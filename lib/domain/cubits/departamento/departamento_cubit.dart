import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/departamento_entity.dart';
import '../../usecases/departamento/departamento_db_usecase.dart';
import '../../usecases/departamento/departamento_usecase.dart';

part '../departamento/departamento_state.dart';

class DepartamentoCubit extends Cubit<DepartamentoState> {
  final DepartamentoUsecase departamento;
  final DepartamentoUsecaseDB departamentoDB;

  DepartamentoCubit({required this.departamento, required this.departamentoDB})
      : super(DepartamentoInitial()) {
    getDepartamentoDB();
  }

  void getDepartamentoDB() async {
    final result = await departamentoDB.getDepartamentosUsecaseDB();
    result.fold((failure) => emit(DepartamentoError(failure.properties.first)),
        (data) => emit(DepartamentoLoaded(data)));
  }
}
