import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/departamento_entity.dart';
import '../../../domain/usecases/departamento/departamento_db_usecase.dart';

part '../departamento/departamento_state.dart';

class DepartamentoCubit extends Cubit<DepartamentoState> {
  final DepartamentoUsecaseDB departamentoDB;

  DepartamentoCubit({required this.departamentoDB})
      : super(DepartamentosInitial()) {
    getDepartamentoDB();
  }

  void initState() => emit(DepartamentosInitial());

  void getDepartamentoDB() async {
    final result = await departamentoDB.getDepartamentosUsecaseDB();
    result.fold((failure) => emit(DepartamentosError(failure.properties.first)),
        (data) => emit(DepartamentosLoaded(data)));
  }
}
