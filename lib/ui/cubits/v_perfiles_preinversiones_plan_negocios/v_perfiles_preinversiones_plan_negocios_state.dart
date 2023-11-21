part of 'v_perfiles_preinversiones_plan_negocios_cubit.dart';

abstract class VPerfilesPreInversionesPlanNegociosState extends Equatable {
  final List<VPerfilPreInversionPlanNegocioEntity>
      vPerfilesPreInversionesPlanNegocios;

  const VPerfilesPreInversionesPlanNegociosState(
      {required this.vPerfilesPreInversionesPlanNegocios});

  @override
  List<Object?> get props => [vPerfilesPreInversionesPlanNegocios];
}

class VPerfilesPreInversionesPlanNegociosInitial
    extends VPerfilesPreInversionesPlanNegociosState {
  VPerfilesPreInversionesPlanNegociosInitial()
      : super(vPerfilesPreInversionesPlanNegocios: []);
}

class VPerfilesPreInversionesPlanNegociosLoading
    extends VPerfilesPreInversionesPlanNegociosState {
  const VPerfilesPreInversionesPlanNegociosLoading(
      {required super.vPerfilesPreInversionesPlanNegocios});
}

class VPerfilesPreInversionesPlanNegociosLoaded
    extends VPerfilesPreInversionesPlanNegociosState {
  final List<VPerfilPreInversionPlanNegocioEntity>
      vPerfilesPreInversionesPlanNegociosLoaded;

  const VPerfilesPreInversionesPlanNegociosLoaded(
      this.vPerfilesPreInversionesPlanNegociosLoaded)
      : super(
            vPerfilesPreInversionesPlanNegocios:
                vPerfilesPreInversionesPlanNegociosLoaded);
}

class VPerfilesPreInversionesPlanNegociosError
    extends VPerfilesPreInversionesPlanNegociosState {
  final String message;

  VPerfilesPreInversionesPlanNegociosError(this.message)
      : super(vPerfilesPreInversionesPlanNegocios: []);
  @override
  List<Object?> get props => [message];
}
