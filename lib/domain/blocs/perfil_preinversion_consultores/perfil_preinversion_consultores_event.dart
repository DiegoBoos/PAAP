part of '../perfil_preinversion_consultores/perfil_preinversion_consultores_bloc.dart';

abstract class PerfilPreInversionConsultoresEvent extends Equatable {
  const PerfilPreInversionConsultoresEvent();

  @override
  List<Object> get props => [];
}

class GetPerfilPreInversionConsultores
    extends PerfilPreInversionConsultoresEvent {
  final String perfilPreInversionId;

  const GetPerfilPreInversionConsultores(this.perfilPreInversionId);
}

class DeletePerfilPreInversionConsultores
    extends PerfilPreInversionConsultoresEvent {}
