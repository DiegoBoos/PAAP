part of 'perfiles_preinversion_bloc.dart';

abstract class PerfilesPreInversionEvent extends Equatable {
  const PerfilesPreInversionEvent();

  @override
  List<Object> get props => [];
}

class GetPerfilesPreInversion extends PerfilesPreInversionEvent {}

class GetPerfilesPreInversionFiltros extends PerfilesPreInversionEvent {
  final String? id;
  final String? nombre;

  const GetPerfilesPreInversionFiltros({this.id, this.nombre});
}
