part of '../perfil_preinversion_cofinanciadores/perfil_preinversion_cofinanciadores_bloc.dart';

abstract class PerfilPreInversionCofinanciadoresState extends Equatable {
  final List<PerfilPreInversionCofinanciadorEntity>?
      perfilPreInversionCofinanciadores;

  const PerfilPreInversionCofinanciadoresState(
      {this.perfilPreInversionCofinanciadores});

  @override
  List<Object> get props => [];
}

class PerfilPreInversionCofinanciadoresInitial
    extends PerfilPreInversionCofinanciadoresState {
  PerfilPreInversionCofinanciadoresInitial()
      : super(perfilPreInversionCofinanciadores: []);
}

class PerfilPreInversionCofinanciadoresLoading
    extends PerfilPreInversionCofinanciadoresState {}

class PerfilPreInversionCofinanciadoresLoaded
    extends PerfilPreInversionCofinanciadoresState {
  final List<PerfilPreInversionCofinanciadorEntity>?
      perfilPreInversionCofinanciadoresLoaded;

  const PerfilPreInversionCofinanciadoresLoaded(
      {this.perfilPreInversionCofinanciadoresLoaded})
      : super(
            perfilPreInversionCofinanciadores:
                perfilPreInversionCofinanciadoresLoaded);
}

class PerfilPreInversionCofinanciadoresError
    extends PerfilPreInversionCofinanciadoresState {
  final String message;

  PerfilPreInversionCofinanciadoresError(this.message)
      : super(perfilPreInversionCofinanciadores: []);
}
