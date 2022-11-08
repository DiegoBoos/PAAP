part of 'perfiles_bloc.dart';

abstract class PerfilesEvent extends Equatable {
  const PerfilesEvent();

  @override
  List<Object> get props => [];
}

class GetPerfiles extends PerfilesEvent {}

class GetPerfilesFiltros extends PerfilesEvent {
  final String? id;
  final String? nombre;

  const GetPerfilesFiltros({this.id, this.nombre});
}
