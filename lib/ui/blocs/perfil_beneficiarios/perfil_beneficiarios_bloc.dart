import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/perfil_beneficiario_entity.dart';
import '../../../domain/usecases/perfil_beneficiario/perfil_beneficiario_db_usecase.dart';

part 'perfil_beneficiarios_event.dart';
part 'perfil_beneficiarios_state.dart';

class PerfilBeneficiariosBloc
    extends Bloc<PerfilBeneficiariosEvent, PerfilBeneficiariosState> {
  final PerfilBeneficiarioUsecaseDB perfilBeneficiarioUsecaseDB;
  PerfilBeneficiariosBloc({required this.perfilBeneficiarioUsecaseDB})
      : super(PerfilBeneficiariosInitial()) {
    on<GetPerfilBeneficiarios>((event, emit) async {
      emit(PerfilBeneficiariosLoading());
      final result = await perfilBeneficiarioUsecaseDB
          .getPerfilBeneficiariosUsecaseDB(event.perfilId);
      result.fold(
          (failure) => emit(PerfilBeneficiariosError(failure.properties.first)),
          (data) => emit(PerfilBeneficiariosLoaded(data)));
    });
  }
}
