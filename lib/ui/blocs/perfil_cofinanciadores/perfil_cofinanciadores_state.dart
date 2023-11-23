part of 'perfil_cofinanciadores_bloc.dart';

abstract class PerfilCofinanciadoresState extends Equatable {
  final List<PerfilCofinanciadorEntity>? perfilCofinanciadores;

  const PerfilCofinanciadoresState({this.perfilCofinanciadores});

  @override
  List<Object> get props => [];
}

class PerfilCofinanciadoresInitial extends PerfilCofinanciadoresState {
  PerfilCofinanciadoresInitial() : super(perfilCofinanciadores: []);
}

class PerfilCofinanciadoresLoading extends PerfilCofinanciadoresState {}

class PerfilCofinanciadoresLoaded extends PerfilCofinanciadoresState {
  final List<PerfilCofinanciadorEntity> perfilCofinanciadoresLoaded;

  const PerfilCofinanciadoresLoaded(this.perfilCofinanciadoresLoaded)
      : super(perfilCofinanciadores: perfilCofinanciadoresLoaded);
}

class PerfilCofinanciadoresError extends PerfilCofinanciadoresState {
  final String message;

  PerfilCofinanciadoresError(this.message) : super(perfilCofinanciadores: []);
}
