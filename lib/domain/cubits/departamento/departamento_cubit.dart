import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/departamento_entity.dart';
import '../../usecases/departamento/departamento_db_usecase.dart';

part '../departamento/departamento_state.dart';

class DepartamentoCubit extends Cubit<DepartamentoState> {
  final DepartamentoUsecaseDB departamentoDB;

  DepartamentoCubit({required this.departamentoDB})
      : super(DepartamentosInitial()) {
    getDepartamentoDB();
  }

  void getDepartamentoDB() async {
    final result = await departamentoDB.getDepartamentosUsecaseDB();
    result.fold((failure) => emit(DepartamentosError(failure.properties.first)),
        (data) => emit(DepartamentosLoaded(data)));
  }
}
