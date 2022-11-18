part of 'perfil_preinversion_cofinanciador_actividad_financiera_cubit.dart';

abstract class PerfilPreInversionCofinanciadorActividadFinancieraState
    extends Equatable {
  final PerfilPreInversionCofinanciadorActividadFinancieraEntity?
      perfilPreInversionCofinanciadorActividadFinanciera;

  const PerfilPreInversionCofinanciadorActividadFinancieraState(
      {this.perfilPreInversionCofinanciadorActividadFinanciera});

  @override
  List<Object?> get props =>
      [perfilPreInversionCofinanciadorActividadFinanciera];
}

class PerfilPreInversionCofinanciadorActividadFinancieraInitial
    extends PerfilPreInversionCofinanciadorActividadFinancieraState {}

class PerfilPreInversionCofinanciadorActividadFinancieraLoading
    extends PerfilPreInversionCofinanciadorActividadFinancieraState {}

class PerfilPreInversionCofinanciadorActividadFinancieraLoaded
    extends PerfilPreInversionCofinanciadorActividadFinancieraState {
  final PerfilPreInversionCofinanciadorActividadFinancieraEntity?
      perfilPreInversionCofinanciadorActividadFinancieraLoaded;

  const PerfilPreInversionCofinanciadorActividadFinancieraLoaded(
      this.perfilPreInversionCofinanciadorActividadFinancieraLoaded)
      : super(
            perfilPreInversionCofinanciadorActividadFinanciera:
                perfilPreInversionCofinanciadorActividadFinancieraLoaded);
}

class PerfilPreInversionCofinanciadorActividadFinancieraError
    extends PerfilPreInversionCofinanciadorActividadFinancieraState {
  final String message;

  const PerfilPreInversionCofinanciadorActividadFinancieraError(this.message);
  @override
  List<Object?> get props => [message];
}
