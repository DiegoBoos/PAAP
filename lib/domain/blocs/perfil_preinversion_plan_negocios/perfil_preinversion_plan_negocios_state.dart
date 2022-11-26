part of 'perfil_preinversion_plan_negocios_bloc.dart';

abstract class PerfilPreInversionPlanNegociosState extends Equatable {
  final List<PerfilPreInversionPlanNegocioEntity>?
      perfilPreInversionPlanNegocios;

  const PerfilPreInversionPlanNegociosState(
      {this.perfilPreInversionPlanNegocios});

  @override
  List<Object?> get props => [perfilPreInversionPlanNegocios];
}

class PerfilPreInversionPlanNegociosInitial
    extends PerfilPreInversionPlanNegociosState {}

class PerfilPreInversionPlanNegociosLoading
    extends PerfilPreInversionPlanNegociosState {}

class PerfilPreInversionPlanNegociosLoaded
    extends PerfilPreInversionPlanNegociosState {
  final List<PerfilPreInversionPlanNegocioEntity>?
      perfilPreInversionPlanNegociosLoaded;

  const PerfilPreInversionPlanNegociosLoaded(
      this.perfilPreInversionPlanNegociosLoaded)
      : super(
            perfilPreInversionPlanNegocios:
                perfilPreInversionPlanNegociosLoaded);
}

class PerfilPreInversionPlanNegociosSaved
    extends PerfilPreInversionPlanNegociosState {}

class PerfilPreInversionPlanNegociosError
    extends PerfilPreInversionPlanNegociosState {
  final String message;

  const PerfilPreInversionPlanNegociosError(this.message);
  @override
  List<Object?> get props => [message];
}
