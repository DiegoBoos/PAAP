part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

class GetMenus extends MenuEvent {
  final String usuarioId;
  final String contrasena;
  final bool isOffline;

  const GetMenus(
      {required this.usuarioId,
      required this.contrasena,
      this.isOffline = false});
}
