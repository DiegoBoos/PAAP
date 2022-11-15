part of 'perfil_preinversion_consultor_cubit.dart';

abstract class PerfilPreInversionConsultorState extends Equatable {
  final PerfilPreInversionConsultorEntity? perfilPreInversionConsultor;
  const PerfilPreInversionConsultorState({this.perfilPreInversionConsultor});

  @override
  List<Object?> get props => [perfilPreInversionConsultor];
}

class PerfilPreInversionConsultorInitial
    extends PerfilPreInversionConsultorState {}

class PerfilPreInversionConsultorLoading
    extends PerfilPreInversionConsultorState {}

class PerfilPreInversionConsultorLoaded
    extends PerfilPreInversionConsultorState {
  final PerfilPreInversionConsultorEntity? perfilPreInversionConsultorLoaded;

  const PerfilPreInversionConsultorLoaded(
      this.perfilPreInversionConsultorLoaded)
      : super(perfilPreInversionConsultor: perfilPreInversionConsultorLoaded);
}

class PerfilPreInversionConsultorError
    extends PerfilPreInversionConsultorState {
  final String message;

  const PerfilPreInversionConsultorError(this.message);

  @override
  List<Object?> get props => [message];
}
