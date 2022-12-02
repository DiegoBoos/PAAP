part of 'perfil_preinversion_planes_negocios_bloc.dart';

abstract class PerfilPreInversionPlanesNegociosState extends Equatable {
  final List<PerfilPreInversionPlanNegocioEntity>?
      perfilPreInversionPlanesNegocios;

  const PerfilPreInversionPlanesNegociosState(
      {this.perfilPreInversionPlanesNegocios});

  @override
  List<Object?> get props => [perfilPreInversionPlanesNegocios];
}

class PerfilPreInversionPlanesNegociosInitial
    extends PerfilPreInversionPlanesNegociosState {}

class PerfilPreInversionPlanesNegociosLoading
    extends PerfilPreInversionPlanesNegociosState {}

class PerfilPreInversionPlanesNegociosLoaded
    extends PerfilPreInversionPlanesNegociosState {
  final List<PerfilPreInversionPlanNegocioEntity>?
      perfilPreInversionPlanesNegociosLoaded;

  const PerfilPreInversionPlanesNegociosLoaded(
      this.perfilPreInversionPlanesNegociosLoaded)
      : super(
            perfilPreInversionPlanesNegocios:
                perfilPreInversionPlanesNegociosLoaded);
}

class PerfilPreInversionPlanesNegociosSaved
    extends PerfilPreInversionPlanesNegociosState {}

class PerfilPreInversionPlanesNegociosError
    extends PerfilPreInversionPlanesNegociosState {
  final String message;

  const PerfilPreInversionPlanesNegociosError(this.message);
  @override
  List<Object?> get props => [message];
}
