part of 'perfil_preinversion_costos_utp_cubit.dart';

abstract class PerfilPreInversionCostosUPTState extends Equatable {
  final VPerfilPreInversionPlanNegocioEntity perfilPreInversionCostosUPT;

  const PerfilPreInversionCostosUPTState(
      {required this.perfilPreInversionCostosUPT});

  @override
  List<Object?> get props => [perfilPreInversionCostosUPT];
}

class PerfilPreInversionCostosUPTInitial
    extends PerfilPreInversionCostosUPTState {
  PerfilPreInversionCostosUPTInitial()
      : super(perfilPreInversionCostosUPT: initObject());
}

class PerfilPreInversionCostosUPTLoaded
    extends PerfilPreInversionCostosUPTState {
  final VPerfilPreInversionPlanNegocioEntity perfilPreInversionCostosUPTLoaded;

  const PerfilPreInversionCostosUPTLoaded(
      this.perfilPreInversionCostosUPTLoaded)
      : super(perfilPreInversionCostosUPT: perfilPreInversionCostosUPTLoaded);
}

class PerfilPreInversionCostosUPTChanged
    extends PerfilPreInversionCostosUPTState {
  final VPerfilPreInversionPlanNegocioEntity perfilPreInversionCostosUPTChanged;

  const PerfilPreInversionCostosUPTChanged(
      this.perfilPreInversionCostosUPTChanged)
      : super(perfilPreInversionCostosUPT: perfilPreInversionCostosUPTChanged);
}

class PerfilPreInversionCostosUPTSaved
    extends PerfilPreInversionCostosUPTState {
  const PerfilPreInversionCostosUPTSaved(
      {required super.perfilPreInversionCostosUPT});
}

class PerfilPreInversionCostosUPTError
    extends PerfilPreInversionCostosUPTState {
  final String message;

  PerfilPreInversionCostosUPTError(this.message)
      : super(perfilPreInversionCostosUPT: initObject());
  @override
  List<Object?> get props => [message];
}

VPerfilPreInversionPlanNegocioEntity initObject() =>
    VPerfilPreInversionPlanNegocioEntity(cantidad: '', valor: '', year: '');
