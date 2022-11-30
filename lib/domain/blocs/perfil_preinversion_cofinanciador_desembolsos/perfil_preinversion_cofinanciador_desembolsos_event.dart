part of 'perfil_preinversion_cofinanciador_desembolsos_bloc.dart';

abstract class PerfilPreInversionCofinanciadorDesembolsosEvent
    extends Equatable {
  const PerfilPreInversionCofinanciadorDesembolsosEvent();

  @override
  List<Object> get props => [];
}

class GetPerfilPreInversionCofinanciadorDesembolsos
    extends PerfilPreInversionCofinanciadorDesembolsosEvent {}

class GetPerfilPreInversionCofinanciadorDesembolsosByCofinanciador
    extends PerfilPreInversionCofinanciadorDesembolsosEvent {
  final String perfilPreInversionId;
  final String cofinanciadorId;
  final String desembolsoId;

  const GetPerfilPreInversionCofinanciadorDesembolsosByCofinanciador(
      {required this.perfilPreInversionId,
      required this.cofinanciadorId,
      required this.desembolsoId});
}
