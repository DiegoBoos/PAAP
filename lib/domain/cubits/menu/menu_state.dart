part of 'menu_cubit.dart';

abstract class MenuState extends Equatable {
  final List<MenuEntity>? menuPadre;
  final List<MenuEntity>? menuHijo;
  const MenuState(this.menuPadre, this.menuHijo);

  @override
  List<Object> get props => [];
}

class MenuLoading extends MenuState {
  const MenuLoading() : super(null, null);
}

class MenuLoaded extends MenuState {
  final List<MenuEntity>? menu;
  final List<MenuEntity>? submenu;

  const MenuLoaded(this.menu, this.submenu) : super(menu, submenu);
}

class MenuError extends MenuState {
  final String message;

  const MenuError(this.message) : super(null, null);
}
