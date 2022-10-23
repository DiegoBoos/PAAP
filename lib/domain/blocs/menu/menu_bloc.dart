import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/menu_entity.dart';
import '../../usecases/menu/menu_db_usecase.dart';
import '../../usecases/menu/menu_usecase.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MenuUsecase menu;
  final MenuUsecaseDB menuDB;

  MenuBloc({required this.menu, required this.menuDB}) : super(MenuInitial()) {
    on<GetMenus>((event, emit) async {
      if (event.isOffline) {
        emit(MenuLoading());
        await _getMenuDB(event, emit);
      } else {
        emit(MenuLoading());
        await _getMenu(event, emit);
      }
    });
  }
  _getMenu(event, emit) async {
    final usuarioId = event.usuarioId;
    final contrasena = event.contrasena;

    final result = await menu.getMenuUsecase(usuarioId, contrasena);
    result.fold((failure) {
      emit(MenuError(failure.properties.first));
    }, (data) async {
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
      await menuDB.saveMenuUsecaseDB(data);
    });
  }

  _getMenuDB(event, emit) async {
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
