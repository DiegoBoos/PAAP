part of 'perfil_preinversion_ingresos_utp_cubit.dart';

abstract class PerfilPreInversionIngresosUPTState extends Equatable {
  final PerfilPreInversionPlanNegocioEntity perfilPreInversionIngresosUPT;

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

class PerfilPreInversionIngresosUPTLoading
    extends PerfilPreInversionIngresosUPTState {
  const PerfilPreInversionIngresosUPTLoading(
      {required super.perfilPreInversionIngresosUPT});
}

class PerfilPreInversionIngresosUPTLoaded
    extends PerfilPreInversionIngresosUPTState {
  final PerfilPreInversionPlanNegocioEntity perfilPreInversionIngresosUPTLoaded;

  const PerfilPreInversionIngresosUPTLoaded(
      this.perfilPreInversionIngresosUPTLoaded)
      : super(
            perfilPreInversionIngresosUPT: perfilPreInversionIngresosUPTLoaded);
}

class PerfilPreInversionIngresosUPTChanged
    extends PerfilPreInversionIngresosUPTState {
  final PerfilPreInversionPlanNegocioEntity
      perfilPreInversionIngresosUPTChanged;

  const PerfilPreInversionIngresosUPTChanged(
      this.perfilPreInversionIngresosUPTChanged)
      : super(
            perfilPreInversionIngresosUPT:
                perfilPreInversionIngresosUPTChanged);
}

class PerfilPreInversionIngresosUPTSaved
    extends PerfilPreInversionIngresosUPTState {
  PerfilPreInversionIngresosUPTSaved()
      : super(perfilPreInversionIngresosUPT: _initObject());
}

class PerfilPreInversionIngresosUPTError
    extends PerfilPreInversionIngresosUPTState {
  final String message;

  PerfilPreInversionIngresosUPTError(this.message)
      : super(perfilPreInversionIngresosUPT: _initObject());
  @override
  List<Object?> get props => [message];
}

PerfilPreInversionPlanNegocioEntity _initObject() =>
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
