import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/menu/menu_bloc.dart';
import '../../../domain/entities/menu_entity.dart';
import '../../utils/custom_drawer.dart';
import '../../utils/network_icon.dart';

class AlianzasPage extends StatefulWidget {
  const AlianzasPage({super.key, required this.menuHijo});
  final List<MenuEntity> menuHijo;

  @override
  State<AlianzasPage> createState() => _AlianzasPageState();
}

class _AlianzasPageState extends State<AlianzasPage> {
  @override
  void initState() {
    super.initState();
    initMenuAlianzas();
  }

  void initMenuAlianzas() {
    final menuBloc = BlocProvider.of<MenuBloc>(context);
    menuAlianzas = menuBloc.state.menuHijo!
        .where((submenu) =>
            submenu.menuPadre == '11' &&
            (submenu.menuId == '43' || submenu.menuId == '44'))
        .toList();

    menuAlianzas.sort((a, b) {
      return a.orden.toLowerCase().compareTo(b.orden.toLowerCase());
    });
  }

  List<MenuEntity> menuAlianzas = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Alianzas'),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: NetworkIcon(),
            )
          ],
        ),
        drawer: CustomDrawer(menuHijo: menuAlianzas),
        body: Container());
  }
}
