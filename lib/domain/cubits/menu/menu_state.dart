part of 'menu_cubit.dart';

abstract class MenuState extends Equatable {
  final List<MenuEntity>? menu;
  const MenuState({this.menu});

  @override
  List<Object?> get props => [menu];
}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final List<MenuEntity>? menuLoaded;

  const MenuLoaded(this.menuLoaded) : super(menu: menuLoaded);
}

class MenuError extends MenuState {
  final String message;

  const MenuError(this.message);

  @override
  List<Object?> get props => [message];
}
