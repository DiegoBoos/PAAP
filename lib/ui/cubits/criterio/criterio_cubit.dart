import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/criterio_entity.dart';
import '../../../domain/usecases/criterio/criterio_db_usecase.dart';

part 'criterio_state.dart';

class CriterioCubit extends Cubit<CriterioState> {
  final CriterioUsecaseDB criterioDB;

  CriterioCubit({required this.criterioDB}) : super(CriteriosInitial());

  Future<void> getCriteriosDB(String agrupacionId) async {
    final result = await criterioDB.getCriteriosUsecaseDB(agrupacionId);
    result.fold((failure) => emit(CriteriosError(failure.properties.first)),
        (data) => emit(CriteriosLoaded(data)));
  }

  void initState() => emit(CriteriosInitial());
}
