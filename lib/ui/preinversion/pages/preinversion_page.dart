import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/menu/menu_bloc.dart';
import '../../../domain/entities/menu_entity.dart';
import '../../utils/custom_drawer.dart';
import '../../utils/network_icon.dart';

class PreinversionPage extends StatefulWidget {
  const PreinversionPage({super.key, required this.menuHijo});
  final List<MenuEntity> menuHijo;

  @override
  State<PreinversionPage> createState() => _PreinversionPageState();
}

class _PreinversionPageState extends State<PreinversionPage> {
  @override
  void initState() {
    super.initState();
    initMenuPreinversion();
  }

  void initMenuPreinversion() {
    final menuBloc = BlocProvider.of<MenuBloc>(context);
    menuPerfilesPreinversion = menuBloc.state.menuHijo!
        .where((submenu) =>
            submenu.menuPadre == '36' &&
            (submenu.menuId == '37' ||
                submenu.menuId == '38' ||
                submenu.menuId == '39' ||
                submenu.menuId == '40' ||
                submenu.menuId == '41' ||
                submenu.menuId == '2067'))
        .toList();

    menuPerfilesPreinversion.sort((a, b) {
      return a.orden.toLowerCase().compareTo(b.orden.toLowerCase());
    });
  }

  List<MenuEntity> menuPerfilesPreinversion = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Preinversion'),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: NetworkIcon(),
            )
          ],
        ),
        drawer: CustomDrawer(menuHijo: menuPerfilesPreinversion),
        body: Container());
  }
}
