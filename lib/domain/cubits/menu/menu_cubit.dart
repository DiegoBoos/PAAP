import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paap/domain/entities/menu_entity.dart';
import '../../usecases/menu/menu_db_usecase.dart';
import '../../usecases/menu/menu_usecase.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  final MenuUsecase menu;
  final MenuUsecaseDB menuDB;

  MenuCubit({required this.menu, required this.menuDB})
      : super(const MenuLoading());

  getMenu(String usuarioId, String contrasena) async {
    final result = await menu.getMenuUsecase(usuarioId, contrasena);
    result.fold((failure) {
      emit(MenuError(failure.properties.first));
    }, (data) async {
      await menuDB.saveMenuUsecaseDB(data);
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
    final result = await menuDB.getMenuUsecaseDB();
    result.fold((failure) {
      emit(MenuError(failure.properties.first));
    }, (data) {
      if (data == null) return emit(const MenuError('No hay datos'));

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
}
