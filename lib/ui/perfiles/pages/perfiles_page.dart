import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/entities/menu_entity.dart';
import '../../utils/custom_drawer.dart';

class PerfilesPage extends StatelessWidget {
  const PerfilesPage({super.key, required this.menuHijo});
  final List<MenuEntity> menuHijo;
  @override
  Widget build(BuildContext context) {
    final menuCubit = BlocProvider.of<MenuCubit>(context, listen: false);
    final menuHijo = menuCubit.state.menuHijo!
        .where((submenu) =>
            submenu.menuPadre == '12' &&
            (submenu.menuId == '22' || submenu.menuId == '31'))
        .toList();

    menuHijo.sort((a, b) {
      return a.orden.toLowerCase().compareTo(b.orden.toLowerCase());
    });
    return Scaffold(
        appBar: AppBar(title: const Text('Perfiles')),
        drawer: CustomDrawer(menuHijo: menuHijo),
        body: Container());
  }
}
