import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/entities/menu_entity.dart';
import '../../utils/custom_drawer.dart';

class AlianzasPage extends StatelessWidget {
  const AlianzasPage({super.key, required this.menuHijo});
  final List<MenuEntity> menuHijo;
  @override
  Widget build(BuildContext context) {
    final menuCubit = BlocProvider.of<MenuCubit>(context, listen: false);
    final menuHijo = menuCubit.state.menuHijo!
        .where((submenu) =>
            submenu.menuPadre == '11' &&
            (submenu.menuId == '43' || submenu.menuId == '44'))
        .toList();

    menuHijo.sort((a, b) {
      return a.orden.toLowerCase().compareTo(b.orden.toLowerCase());
    });
    return Scaffold(
        appBar: AppBar(title: const Text('Alianzas')),
        drawer: CustomDrawer(menuHijo: menuHijo),
        body: Container());
  }
}
