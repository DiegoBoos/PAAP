part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {
  final List<MenuEntity>? menuPadre;
  final List<MenuEntity>? menuHijo;
  const MenuState({this.menuPadre, this.menuHijo});

  @override
  List<Object?> get props => [menuPadre, menuHijo];
}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final List<MenuEntity>? menu;
  final List<MenuEntity>? submenu;

  const MenuLoaded(this.menu, this.submenu)
      : super(menuPadre: menu, menuHijo: submenu);

  @override
  List<Object?> get props => [menu, submenu];
}

class MenuError extends MenuState {
  final String message;

  const MenuError(this.message);

  @override
  List<Object?> get props => [message];
}
