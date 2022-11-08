part of 'menu_cubit.dart';

abstract class MenuState extends Equatable {
  final List<MenuEntity>? menus;
  const MenuState({this.menus});

  @override
  List<Object?> get props => [menus];
}

class MenusInitial extends MenuState {}

class MenusLoading extends MenuState {}

class MenusLoaded extends MenuState {
  final List<MenuEntity>? menusLoaded;

  const MenusLoaded(this.menusLoaded) : super(menus: menusLoaded);
}

class MenusError extends MenuState {
  final String message;

  const MenusError(this.message);

  @override
  List<Object?> get props => [message];
}
