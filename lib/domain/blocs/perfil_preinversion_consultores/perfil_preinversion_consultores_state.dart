part of '../perfil_preinversion_consultores/perfil_preinversion_consultores_bloc.dart';

abstract class PerfilPreInversionConsultoresState extends Equatable {
  const PerfilPreInversionConsultoresState();

  @override
  List<Object> get props => [];
}

class PerfilPreInversionConsultoresInitial
    extends PerfilPreInversionConsultoresState {}

class PerfilPreInversionConsultoresLoading
    extends PerfilPreInversionConsultoresState {}

class PerfilPreInversionConsultoresLoaded
    extends PerfilPreInversionConsultoresState {
  final List<PerfilPreInversionConsultorEntity>?
      perfilPreInversionConsultoresLoaded;

  const PerfilPreInversionConsultoresLoaded(
      {this.perfilPreInversionConsultoresLoaded});
}

class PerfilPreInversionConsultoresError
    extends PerfilPreInversionConsultoresState {
  final String message;

  const PerfilPreInversionConsultoresError(this.message);
}
