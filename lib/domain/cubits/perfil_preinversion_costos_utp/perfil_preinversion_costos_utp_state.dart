part of 'perfil_preinversion_costos_utp_cubit.dart';

abstract class PerfilPreInversionCostosUPTState extends Equatable {
  final PerfilPreInversionPlanNegocioEntity perfilPreInversionCostosUPT;

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

class PerfilPreInversionCostosUPTLoading
    extends PerfilPreInversionCostosUPTState {
  const PerfilPreInversionCostosUPTLoading(
      {required super.perfilPreInversionCostosUPT});
}

class PerfilPreInversionCostosUPTLoaded
    extends PerfilPreInversionCostosUPTState {
  final PerfilPreInversionPlanNegocioEntity perfilPreInversionCostosUPTLoaded;

  const PerfilPreInversionCostosUPTLoaded(
      this.perfilPreInversionCostosUPTLoaded)
      : super(perfilPreInversionCostosUPT: perfilPreInversionCostosUPTLoaded);
}

class PerfilPreInversionCostosUPTChanged
    extends PerfilPreInversionCostosUPTState {
  final PerfilPreInversionPlanNegocioEntity perfilPreInversionCostosUPTChanged;

  const PerfilPreInversionCostosUPTChanged(
      this.perfilPreInversionCostosUPTChanged)
      : super(perfilPreInversionCostosUPT: perfilPreInversionCostosUPTChanged);
}

class PerfilPreInversionCostosUPTSaved
    extends PerfilPreInversionCostosUPTState {
  PerfilPreInversionCostosUPTSaved()
      : super(perfilPreInversionCostosUPT: initObject());
}

class PerfilPreInversionCostosUPTError
    extends PerfilPreInversionCostosUPTState {
  final String message;

  PerfilPreInversionCostosUPTError(this.message)
      : super(perfilPreInversionCostosUPT: initObject());
  @override
  List<Object?> get props => [message];
}

PerfilPreInversionPlanNegocioEntity initObject() =>
    PerfilPreInversionPlanNegocioEntity(
        perfilPreInversionId: '',
        rubroId: '',
        year: '',
        valor: '',
        cantidad: '',
        unidadId: '',
        productoId: '',
        tipoCalidadId: '',
        recordStatus: '');
