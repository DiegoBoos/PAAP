part of '../perfil_preinversion_cofinanciadores/perfil_preinversion_cofinanciadores_bloc.dart';

abstract class PerfilPreInversionCofinanciadoresEvent extends Equatable {
  const PerfilPreInversionCofinanciadoresEvent();

  @override
  List<Object> get props => [];
}

class GetPerfilPreInversionCofinanciadores
    extends PerfilPreInversionCofinanciadoresEvent {}
