import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../entities/menu_entity.dart';
import '../../usecases/menu/menu_db_usecase.dart';
import '../../usecases/menu/menu_usecase.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  final MenuUsecase menu;
  final MenuUsecaseDB menuDB;

  MenuCubit({required this.menu, required this.menuDB}) : super(MenuInitial()) {
    getMenuDB();
  }

  void getMenuDB() async {
    final result = await menuDB.getMenuUsecaseDB();
    result.fold((failure) => emit(MenuError(failure.properties.first)),
        (data) => emit(MenuLoaded(data)));
  }
}
