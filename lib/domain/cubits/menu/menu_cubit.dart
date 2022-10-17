import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paap/domain/entities/menu_entity.dart';

import '../../blocs/auth/auth_bloc.dart';
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
    }, (data) async {
      await menuDB.guardarMenuDB(data);
      final menuPadre = data
          .where((menu) =>
              menu.tipoMenuId == '1' &&
              (menu.menuId == '1' ||
                  menu.menuId == '11' ||
                  menu.menuId == '12' ||
                  menu.menuId == '36'))
          .toList();
      final menuHijo = data
          .where((menu) =>
              menu.tipoMenuId == '2' &&
              (menu.menuPadre == '1' ||
                  menu.menuPadre == '11' ||
                  menu.menuPadre == '12' ||
                  menu.menuPadre == '36'))
          .toList();

      // order by orden
      menuPadre.sort((a, b) {
        return a.orden.toLowerCase().compareTo(b.orden.toLowerCase());
      });

      emit(MenuLoaded(menuPadre, menuHijo));
    });
  }

  getMenuDB() async {
    final result = await menuDB.getMenuDB();
    result.fold((failure) {
      emit(MenuError(failure.properties.first));
    }, (data) {
      final menuPadre = data
          .where((menu) =>
              menu.tipoMenuId == '1' &&
              (menu.menuId == '1' ||
                  menu.menuId == '11' ||
                  menu.menuId == '12' ||
                  menu.menuId == '36'))
          .toList();
      final menuHijo = data
          .where((menu) =>
              menu.tipoMenuId == '2' &&
              (menu.menuPadre == '1' ||
                  menu.menuPadre == '11' ||
                  menu.menuPadre == '12' ||
                  menu.menuPadre == '36'))
          .toList();

      // order by orden
      menuPadre.sort((a, b) {
        return a.orden.toLowerCase().compareTo(b.orden.toLowerCase());
      });

      emit(MenuLoaded(menuPadre, menuHijo));
    });
  }

  /* Future<void> guardarMenu(Emitter<AuthState> emit, MenuEntity data) async {
    final result = await menuDB.guardarMenuDB(data);
    result.fold((failure) {
      emit(AuthError(failure.properties.first));
    }, (_) {});
  } */
}
