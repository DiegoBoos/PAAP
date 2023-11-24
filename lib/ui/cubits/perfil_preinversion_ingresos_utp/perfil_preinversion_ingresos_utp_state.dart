part of 'perfil_preinversion_ingresos_utp_cubit.dart';

abstract class PerfilPreInversionIngresosUPTState extends Equatable {
  final VPerfilPreInversionPlanNegocioEntity perfilPreInversionIngresosUPT;

  const PerfilPreInversionIngresosUPTState(
      {required this.perfilPreInversionIngresosUPT});

  @override
  List<Object?> get props => [perfilPreInversionIngresosUPT];
}

class PerfilPreInversionIngresosUPTInitial
    extends PerfilPreInversionIngresosUPTState {
  PerfilPreInversionIngresosUPTInitial()
      : super(perfilPreInversionIngresosUPT: _initObject());
}

class PerfilPreInversionIngresosUPTLoaded
    extends PerfilPreInversionIngresosUPTState {
  final VPerfilPreInversionPlanNegocioEntity
      perfilPreInversionIngresosUPTLoaded;

  const PerfilPreInversionIngresosUPTLoaded(
      this.perfilPreInversionIngresosUPTLoaded)
      : super(
            perfilPreInversionIngresosUPT: perfilPreInversionIngresosUPTLoaded);
}

class PerfilPreInversionIngresosUPTChanged
    extends PerfilPreInversionIngresosUPTState {
  final VPerfilPreInversionPlanNegocioEntity
      perfilPreInversionIngresosUPTChanged;

  const PerfilPreInversionIngresosUPTChanged(
      this.perfilPreInversionIngresosUPTChanged)
      : super(
            perfilPreInversionIngresosUPT:
                perfilPreInversionIngresosUPTChanged);
}

class PerfilPreInversionIngresosUPTSaved
    extends PerfilPreInversionIngresosUPTState {
  const PerfilPreInversionIngresosUPTSaved(
      {required super.perfilPreInversionIngresosUPT});
}

class PerfilPreInversionIngresosUPTError
    extends PerfilPreInversionIngresosUPTState {
  final String message;

  PerfilPreInversionIngresosUPTError(this.message)
      : super(perfilPreInversionIngresosUPT: _initObject());
  @override
  List<Object?> get props => [message];
}

VPerfilPreInversionPlanNegocioEntity _initObject() =>
    VPerfilPreInversionPlanNegocioEntity(
      year: '',
      cantidad: '',
      valor: '',
    );
