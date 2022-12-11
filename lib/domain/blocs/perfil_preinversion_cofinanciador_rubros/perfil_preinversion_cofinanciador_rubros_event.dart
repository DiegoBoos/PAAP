part of 'perfil_preinversion_cofinanciador_rubros_bloc.dart';

abstract class PerfilPreInversionCofinanciadorRubrosEvent extends Equatable {
  const PerfilPreInversionCofinanciadorRubrosEvent();

  @override
  List<Object> get props => [];
}

class GetPerfilPreInversionCofinanciadorRubros
    extends PerfilPreInversionCofinanciadorRubrosEvent {}

class GetPerfilPreInversionCofinanciadorRubrosByCofinanciador
    extends PerfilPreInversionCofinanciadorRubrosEvent {
  final String perfilPreInversionId;
  final String cofinanciadorId;

  const GetPerfilPreInversionCofinanciadorRubrosByCofinanciador(
      {required this.perfilPreInversionId, required this.cofinanciadorId});
}
