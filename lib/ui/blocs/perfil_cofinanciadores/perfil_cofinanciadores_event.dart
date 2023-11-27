part of 'perfil_cofinanciadores_bloc.dart';

abstract class PerfilCofinanciadoresEvent extends Equatable {
  const PerfilCofinanciadoresEvent();

  @override
  List<Object> get props => [];
}

class GetPerfilCofinanciadores extends PerfilCofinanciadoresEvent {
  final String perfilId;

  const GetPerfilCofinanciadores(this.perfilId);
}
