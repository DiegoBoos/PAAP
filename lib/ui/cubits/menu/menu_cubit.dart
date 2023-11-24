import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/menu_entity.dart';
import '../../../domain/usecases/menu/menu_db_usecase.dart';
import '../../../domain/usecases/menu/menu_usecase.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  final MenuUsecase menu;
  final MenuUsecaseDB menuDB;

  MenuCubit({required this.menu, required this.menuDB}) : super(MenusInitial());

  Future<String> verificacionDatosLocalesDB() async {
    final result = await menuDB.verificacionDatosLocalesUsecaseDB();
    return result.fold((failure) {
      return failure.properties.first.toString();
    }, (data) {
      if (data == 0) {
        return 'No existen datos. Inicie sesión con conexión a internet';
      }
      return '';
    });
  }

  void getMenuDB() async {
    final result = await menuDB.getMenuUsecaseDB();
    result.fold((failure) => emit(MenusError(failure.properties.first)),
        (data) => emit(MenusLoaded(data)));
  }

  List<MenuEntity> preInversionMenuSorted(List<MenuEntity> menu) {
    final preinversionMenu = menu
        .where((menu) =>
            menu.menuId == '36' ||
            menu.menuId == '37' ||
            menu.menuId == '38' ||
            menu.menuId == '39' ||
            menu.menuId == '40' ||
            menu.menuId == '41' ||
            menu.menuId == '1069')
        .toList();
    preinversionMenu.sort((a, b) {
      return a.orden!.toLowerCase().compareTo(b.orden!.toLowerCase());
    });
    return preinversionMenu;
  }

  List<MenuEntity> perfilesMenuSorted(List<MenuEntity> menu) {
    final perfilesMenu = menu
        .where((menu) =>
            menu.menuId == '12' ||
            menu.menuId == '22' ||
            menu.menuId == '31' ||
            menu.menuId == '18' ||
            menu.menuId == '14' ||
            menu.menuId == '21')
        .toList();

    perfilesMenu.sort((a, b) {
      return a.orden!.toLowerCase().compareTo(b.orden!.toLowerCase());
    });
    return perfilesMenu;
  }

  List<MenuEntity> alianzaMenuSorted(List<MenuEntity> menu) {
    final alianzasMenu = menu
        .where((menu) =>
            menu.menuId == '11' || menu.menuId == '43' || menu.menuId == '44')
        .toList();
    alianzasMenu.sort((a, b) {
      return a.orden!.toLowerCase().compareTo(b.orden!.toLowerCase());
    });
    return alianzasMenu;
  }
}
