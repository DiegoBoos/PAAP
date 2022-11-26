part of 'perfil_preinversion_plan_negocio_cubit.dart';

abstract class PerfilPreInversionPlanNegocioState extends Equatable {
  final PerfilPreInversionPlanNegocioEntity perfilPreInversionPlanNegocio;

  const PerfilPreInversionPlanNegocioState(
      {required this.perfilPreInversionPlanNegocio});

  @override
  List<Object?> get props => [perfilPreInversionPlanNegocio];
}

class PerfilPreInversionPlanNegocioInitial
    extends PerfilPreInversionPlanNegocioState {
  PerfilPreInversionPlanNegocioInitial()
      : super(perfilPreInversionPlanNegocio: initObject());
}

class PerfilPreInversionPlanNegocioLoading
    extends PerfilPreInversionPlanNegocioState {
  const PerfilPreInversionPlanNegocioLoading(
      {required super.perfilPreInversionPlanNegocio});
}

class PerfilPreInversionPlanNegocioLoaded
    extends PerfilPreInversionPlanNegocioState {
  final PerfilPreInversionPlanNegocioEntity perfilPreInversionPlanNegocioLoaded;

  const PerfilPreInversionPlanNegocioLoaded(
      this.perfilPreInversionPlanNegocioLoaded)
      : super(
            perfilPreInversionPlanNegocio: perfilPreInversionPlanNegocioLoaded);
}

class PerfilPreInversionPlanNegocioChanged
    extends PerfilPreInversionPlanNegocioState {
  final PerfilPreInversionPlanNegocioEntity
      perfilPreInversionPlanNegocioChanged;

  const PerfilPreInversionPlanNegocioChanged(
      this.perfilPreInversionPlanNegocioChanged)
      : super(
            perfilPreInversionPlanNegocio:
                perfilPreInversionPlanNegocioChanged);
}

class PerfilPreInversionPlanNegocioSaved
    extends PerfilPreInversionPlanNegocioState {
  PerfilPreInversionPlanNegocioSaved()
      : super(perfilPreInversionPlanNegocio: initObject());
}

class PerfilPreInversionPlanNegocioError
    extends PerfilPreInversionPlanNegocioState {
  final String message;

  PerfilPreInversionPlanNegocioError(this.message)
      : super(perfilPreInversionPlanNegocio: initObject());
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
