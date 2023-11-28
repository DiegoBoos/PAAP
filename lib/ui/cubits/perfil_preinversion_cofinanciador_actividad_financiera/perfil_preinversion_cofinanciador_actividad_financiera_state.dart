part of 'perfil_preinversion_cofinanciador_actividad_financiera_cubit.dart';

abstract class PerfilPreInversionCofinanciadorActividadFinancieraState
    extends Equatable {
  final PerfilPreInversionCofinanciadorActividadFinancieraEntity
      perfilPreInversionCofinanciadorActividadFinanciera;

  const PerfilPreInversionCofinanciadorActividadFinancieraState(
      {required this.perfilPreInversionCofinanciadorActividadFinanciera});

  @override
  List<Object?> get props =>
      [perfilPreInversionCofinanciadorActividadFinanciera];
}

class PerfilPreInversionCofinanciadorActividadFinancieraInitial
    extends PerfilPreInversionCofinanciadorActividadFinancieraState {
  PerfilPreInversionCofinanciadorActividadFinancieraInitial()
      : super(
            perfilPreInversionCofinanciadorActividadFinanciera:
                PerfilPreInversionCofinanciadorActividadFinancieraEntity());
}

class PerfilPreInversionCofinanciadorActividadFinancieraLoaded
    extends PerfilPreInversionCofinanciadorActividadFinancieraState {
  final PerfilPreInversionCofinanciadorActividadFinancieraEntity
      perfilPreInversionCofinanciadorActividadFinancieraLoaded;

  const PerfilPreInversionCofinanciadorActividadFinancieraLoaded(
      this.perfilPreInversionCofinanciadorActividadFinancieraLoaded)
      : super(
            perfilPreInversionCofinanciadorActividadFinanciera:
                perfilPreInversionCofinanciadorActividadFinancieraLoaded);
}

class PerfilPreInversionCofinanciadorActividadFinancieraChanged
    extends PerfilPreInversionCofinanciadorActividadFinancieraState {
  final PerfilPreInversionCofinanciadorActividadFinancieraEntity
      perfilPreInversionCofinanciadorActividadFinancieraChanged;

  const PerfilPreInversionCofinanciadorActividadFinancieraChanged(
      this.perfilPreInversionCofinanciadorActividadFinancieraChanged)
      : super(
            perfilPreInversionCofinanciadorActividadFinanciera:
                perfilPreInversionCofinanciadorActividadFinancieraChanged);
}

class PerfilPreInversionCofinanciadorActividadFinancieraSaved
    extends PerfilPreInversionCofinanciadorActividadFinancieraState {
  const PerfilPreInversionCofinanciadorActividadFinancieraSaved(
      {required super.perfilPreInversionCofinanciadorActividadFinanciera});
}

class PerfilPreInversionCofinanciadorActividadFinancieraError
    extends PerfilPreInversionCofinanciadorActividadFinancieraState {
  final String message;

  PerfilPreInversionCofinanciadorActividadFinancieraError(this.message)
      : super(
            perfilPreInversionCofinanciadorActividadFinanciera:
                PerfilPreInversionCofinanciadorActividadFinancieraEntity());
  @override
  List<Object?> get props => [message];
}
