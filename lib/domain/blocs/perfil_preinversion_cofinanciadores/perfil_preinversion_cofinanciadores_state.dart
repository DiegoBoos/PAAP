part of '../perfil_preinversion_cofinanciadores/perfil_preinversion_cofinanciadores_bloc.dart';

abstract class PerfilPreInversionCofinanciadoresState extends Equatable {
  const PerfilPreInversionCofinanciadoresState();

  @override
  List<Object> get props => [];
}

class PerfilPreInversionCofinanciadoresInitial
    extends PerfilPreInversionCofinanciadoresState {}

class PerfilPreInversionCofinanciadoresLoading
    extends PerfilPreInversionCofinanciadoresState {}

class PerfilPreInversionCofinanciadoresLoaded
    extends PerfilPreInversionCofinanciadoresState {
  final List<PerfilPreInversionCofinanciadorEntity>?
      perfilPreInversionCofinanciadoresLoaded;

  const PerfilPreInversionCofinanciadoresLoaded(
      {this.perfilPreInversionCofinanciadoresLoaded});
}

class PerfilPreInversionCofinanciadoresError
    extends PerfilPreInversionCofinanciadoresState {
  final String message;

  const PerfilPreInversionCofinanciadoresError(this.message);
}
