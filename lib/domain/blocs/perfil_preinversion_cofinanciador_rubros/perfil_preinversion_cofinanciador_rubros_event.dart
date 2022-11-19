part of 'perfil_preinversion_cofinanciador_rubros_bloc.dart';

abstract class PerfilPreInversionCofinanciadorRubrosEvent extends Equatable {
  const PerfilPreInversionCofinanciadorRubrosEvent();

  @override
  List<Object> get props => [];
}

class GetPerfilPreInversionCofinanciadorRubros
    extends PerfilPreInversionCofinanciadorRubrosEvent {
  final String cofinanciadorId;

  const GetPerfilPreInversionCofinanciadorRubros(
      {required this.cofinanciadorId});
}

class GetPerfilPreInversionCofinanciadorRubrosByCofinanciador
    extends PerfilPreInversionCofinanciadorRubrosEvent {
  final String cofinanciadorId;

  const GetPerfilPreInversionCofinanciadorRubrosByCofinanciador(
      {required this.cofinanciadorId});
}
