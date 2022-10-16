import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/entities/menu_entity.dart';
import '../../utils/custom_drawer.dart';

class PreinversionPage extends StatelessWidget {
  const PreinversionPage({super.key, required this.menuHijo});
  final List<MenuEntity> menuHijo;
  @override
  Widget build(BuildContext context) {
    final menuCubit = BlocProvider.of<MenuCubit>(context, listen: false);
    final menuHijo = menuCubit.state.menuHijo!
        .where((submenu) =>
            submenu.menuPadre == '36' &&
            (submenu.menuId == '37' ||
                submenu.menuId == '38' ||
                submenu.menuId == '39' ||
                submenu.menuId == '40' ||
                submenu.menuId == '41' ||
                submenu.menuId == '2067'))
        .toList();

    menuHijo.sort((a, b) {
      return a.orden.toLowerCase().compareTo(b.orden.toLowerCase());
    });
    return Scaffold(
        appBar: AppBar(title: const Text('Preinversion')),
        drawer: CustomDrawer(menuHijo: menuHijo),
        body: Container());
  }
}
