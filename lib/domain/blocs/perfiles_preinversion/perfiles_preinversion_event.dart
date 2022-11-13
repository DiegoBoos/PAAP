part of 'perfiles_preinversion_bloc.dart';

abstract class PerfilesPreinversionEvent extends Equatable {
  const PerfilesPreinversionEvent();

  @override
  List<Object> get props => [];
}

class GetPerfilesPreinversion extends PerfilesPreinversionEvent {}

class GetPerfilesPreinversionFiltros extends PerfilesPreinversionEvent {
  final String? id;
  final String? nombre;

  const GetPerfilesPreinversionFiltros({this.id, this.nombre});
}
