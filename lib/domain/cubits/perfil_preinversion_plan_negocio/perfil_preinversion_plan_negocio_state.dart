part of 'perfil_preinversion_plan_negocio_cubit.dart';

abstract class PerfilPreInversionPlanNegocioState extends Equatable {
  final List<PerfilPreInversionPlanNegocioEntity>?
      perfilPreInversionPlanNegocios;

  const PerfilPreInversionPlanNegocioState(
      {this.perfilPreInversionPlanNegocios});

  @override
  List<Object?> get props => [perfilPreInversionPlanNegocios];
}

class PerfilPreInversionPlanNegociosInitial
    extends PerfilPreInversionPlanNegocioState {}

class PerfilPreInversionPlanNegociosLoading
    extends PerfilPreInversionPlanNegocioState {}

class PerfilPreInversionPlanNegociosLoaded
    extends PerfilPreInversionPlanNegocioState {
  final List<PerfilPreInversionPlanNegocioEntity>?
      perfilPreInversionPlanNegociosLoaded;

  const PerfilPreInversionPlanNegociosLoaded(
      this.perfilPreInversionPlanNegociosLoaded)
      : super(
            perfilPreInversionPlanNegocios:
                perfilPreInversionPlanNegociosLoaded);
}

class PerfilPreInversionPlanNegocioSaved
    extends PerfilPreInversionPlanNegocioState {}

class PerfilPreInversionPlanNegocioError
    extends PerfilPreInversionPlanNegocioState {
  final String message;

  const PerfilPreInversionPlanNegocioError(this.message);
  @override
  List<Object?> get props => [message];
}
