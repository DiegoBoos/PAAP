part of '../perfil_preinversion_cofinanciador_actividades_financieras/perfil_preinversion_cofinanciador_actividades_financieras_bloc.dart';

abstract class PerfilPreInversionCofinanciadorActividadesFinancierasEvent
    extends Equatable {
  const PerfilPreInversionCofinanciadorActividadesFinancierasEvent();

  @override
  List<Object> get props => [];
}

class GetPerfilPreInversionCofinanciadorActividadesFinancieras
    extends PerfilPreInversionCofinanciadorActividadesFinancierasEvent {}

class GetPerfilPreInversionCofinanciadorActividadesFinancierasByCofinanciador
    extends PerfilPreInversionCofinanciadorActividadesFinancierasEvent {
  final String perfilPreInversionId;
  final String cofinanciadorId;

  const GetPerfilPreInversionCofinanciadorActividadesFinancierasByCofinanciador(
      {required this.perfilPreInversionId, required this.cofinanciadorId});
}
