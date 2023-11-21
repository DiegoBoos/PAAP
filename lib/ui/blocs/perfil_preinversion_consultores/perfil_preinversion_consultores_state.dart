part of '../perfil_preinversion_consultores/perfil_preinversion_consultores_bloc.dart';

abstract class PerfilPreInversionConsultoresState extends Equatable {
  final List<PerfilPreInversionConsultorEntity>? perfilPreInversionConsultores;
  const PerfilPreInversionConsultoresState(
      {this.perfilPreInversionConsultores});

  @override
  List<Object?> get props => [perfilPreInversionConsultores];
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
      {this.perfilPreInversionConsultoresLoaded})
      : super(
            perfilPreInversionConsultores: perfilPreInversionConsultoresLoaded);
}

class PerfilPreInversionConsultoresError
    extends PerfilPreInversionConsultoresState {
  final String message;

  const PerfilPreInversionConsultoresError(this.message);
}
