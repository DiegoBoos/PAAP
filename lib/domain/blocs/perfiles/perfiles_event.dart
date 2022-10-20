part of 'perfiles_bloc.dart';

abstract class PerfilesEvent extends Equatable {
  const PerfilesEvent();

  @override
  List<Object> get props => [];
}

class GetPerfiles extends PerfilesEvent {
  final String usuarioId;
  final String contrasena;
  final bool isOffline;

  const GetPerfiles(
      {required this.usuarioId,
      required this.contrasena,
      this.isOffline = false});
}
