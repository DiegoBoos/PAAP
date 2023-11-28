part of 'perfil_preinversion_consultor_cubit.dart';

abstract class PerfilPreInversionConsultorState extends Equatable {
  final PerfilPreInversionConsultorEntity perfilPreInversionConsultor;
  const PerfilPreInversionConsultorState(
      {required this.perfilPreInversionConsultor});

  @override
  List<Object?> get props => [perfilPreInversionConsultor];
}

class PerfilPreInversionConsultorInitial
    extends PerfilPreInversionConsultorState {
  PerfilPreInversionConsultorInitial()
      : super(perfilPreInversionConsultor: PerfilPreInversionConsultorEntity());
}

class PerfilPreInversionConsultorLoading
    extends PerfilPreInversionConsultorState {
  const PerfilPreInversionConsultorLoading(
      {required super.perfilPreInversionConsultor});
}

class PerfilPreInversionConsultorLoaded
    extends PerfilPreInversionConsultorState {
  final PerfilPreInversionConsultorEntity perfilPreInversionConsultorLoaded;

  const PerfilPreInversionConsultorLoaded(
      this.perfilPreInversionConsultorLoaded)
      : super(perfilPreInversionConsultor: perfilPreInversionConsultorLoaded);
}

class PerfilPreInversionConsultorSaved
    extends PerfilPreInversionConsultorState {
  PerfilPreInversionConsultorSaved()
      : super(perfilPreInversionConsultor: PerfilPreInversionConsultorEntity());
}

class PerfilPreInversionConsultorError
    extends PerfilPreInversionConsultorState {
  final String message;

  PerfilPreInversionConsultorError(this.message)
      : super(perfilPreInversionConsultor: PerfilPreInversionConsultorEntity());

  @override
  List<Object?> get props => [message];
}
