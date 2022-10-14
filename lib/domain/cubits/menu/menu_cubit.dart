import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paap/domain/entities/menu_entity.dart';

import '../../usecases/menu.dart';
import '../../usecases/menu_db.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  final Menu menu;
  final MenuDB menuDB;

  MenuCubit({required this.menu, required this.menuDB})
      : super(const MenuLoading());

  getMenu({String? usuarioId, String? contrasena}) async {
    final result = await menu.getMenu(usuarioId!, contrasena!);
    result.fold((failure) {
      emit(MenuError(failure.properties.first));
    }, (data) {
      final menuPadre = data.where((menu) => menu.tipoMenuId == '1').toList();
      final menuHijo = data.where((menu) => menu.tipoMenuId == '2').toList();
      emit(MenuLoaded(menuPadre, menuHijo));
    });
  }
}
