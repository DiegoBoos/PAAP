part of 'alianzas_bloc.dart';

abstract class AlianzasEvent extends Equatable {
  const AlianzasEvent();

  @override
  List<Object> get props => [];
}

class GetAlianzas extends AlianzasEvent {}

class GetAlianzasFiltros extends AlianzasEvent {
  final String id;
  final String nombre;

  const GetAlianzasFiltros({required this.id, required this.nombre});
}
