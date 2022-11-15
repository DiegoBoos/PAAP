part of 'perfil_preinversion_cofinanciador_actividad_financiera_cubit.dart';

abstract class PerfilPreInversionCofinanciadorActividadFinancieraState
    extends Equatable {
  final List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>?
      perfilPreInversionCofinanciadorActividadesFinancieras;

  const PerfilPreInversionCofinanciadorActividadFinancieraState(
      {this.perfilPreInversionCofinanciadorActividadesFinancieras});

  @override
  List<Object?> get props =>
      [perfilPreInversionCofinanciadorActividadesFinancieras];
}

class PerfilPreInversionCofinanciadorActividadesFinancierasInitial
    extends PerfilPreInversionCofinanciadorActividadFinancieraState {}

class PerfilPreInversionCofinanciadorActividadesFinancierasLoading
    extends PerfilPreInversionCofinanciadorActividadFinancieraState {}

class PerfilPreInversionCofinanciadorActividadesFinancierasLoaded
    extends PerfilPreInversionCofinanciadorActividadFinancieraState {
  final List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>?
      perfilPreInversionCofinanciadorActividadesFinancierasLoaded;

  const PerfilPreInversionCofinanciadorActividadesFinancierasLoaded(
      this.perfilPreInversionCofinanciadorActividadesFinancierasLoaded)
      : super(
            perfilPreInversionCofinanciadorActividadesFinancieras:
                perfilPreInversionCofinanciadorActividadesFinancierasLoaded);
}

class PerfilPreInversionCofinanciadorActividadesFinancierasError
    extends PerfilPreInversionCofinanciadorActividadFinancieraState {
  final String message;

  const PerfilPreInversionCofinanciadorActividadesFinancierasError(
      this.message);
  @override
  List<Object?> get props => [message];
}
