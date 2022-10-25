part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

class GetMenus extends MenuEvent {
  final UsuarioEntity usuario;
  final bool isOffline;

  const GetMenus({required this.usuario, this.isOffline = false});
}
