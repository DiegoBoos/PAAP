part of '../perfil_preinversion_cofinanciador_actividades_financieras/perfil_preinversion_cofinanciador_actividades_financieras_bloc.dart';

abstract class PerfilPreInversionCofinanciadorActividadesFinancierasState
    extends Equatable {
  final List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>?
      perfilPreInversionCofinanciadorActividadesFinancieras;

  const PerfilPreInversionCofinanciadorActividadesFinancierasState(
      {this.perfilPreInversionCofinanciadorActividadesFinancieras});

  @override
  List<Object?> get props =>
      [perfilPreInversionCofinanciadorActividadesFinancieras];
}

class PerfilPreInversionCofinanciadorActividadesFinancierasInitial
    extends PerfilPreInversionCofinanciadorActividadesFinancierasState {}

class PerfilPreInversionCofinanciadorActividadesFinancierasLoading
    extends PerfilPreInversionCofinanciadorActividadesFinancierasState {}

class PerfilPreInversionCofinanciadorActividadesFinancierasLoaded
    extends PerfilPreInversionCofinanciadorActividadesFinancierasState {
  final List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>?
      perfilPreInversionCofinanciadorActividadesFinancierasLoaded;

  const PerfilPreInversionCofinanciadorActividadesFinancierasLoaded(
      this.perfilPreInversionCofinanciadorActividadesFinancierasLoaded)
      : super(
            perfilPreInversionCofinanciadorActividadesFinancieras:
                perfilPreInversionCofinanciadorActividadesFinancierasLoaded);
}

class PerfilPreInversionCofinanciadorActividadesFinancierasError
    extends PerfilPreInversionCofinanciadorActividadesFinancierasState {
  final String message;

  const PerfilPreInversionCofinanciadorActividadesFinancierasError(
      this.message);
  @override
  List<Object?> get props => [message];
}
