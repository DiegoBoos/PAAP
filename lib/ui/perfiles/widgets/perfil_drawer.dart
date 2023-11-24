import 'package:flutter/material.dart';

import '../../../domain/entities/menu_entity.dart';

class PerfilDrawer extends StatelessWidget {
  const PerfilDrawer({Key? key, required this.menuHijo}) : super(key: key);
  final List<MenuEntity> menuHijo;
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.white,
        child: ListView.builder(
          itemCount: menuHijo.length,
          itemBuilder: (BuildContext context, int index) {
            final submenu = menuHijo[index];

            return ListTile(
                leading: setIcon(submenu),
                title: Text(submenu.nombre!),
                onTap: () {
                  if (submenu.menuId == '12') {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    return;
                  }

                  Navigator.pushNamed(context, submenu.ruta!);
                });
          },
        ));
  }

  Icon? setIcon(MenuEntity submenu) {
    if (submenu.menuId == '12') return const Icon(Icons.group);
    if (submenu.menuId == '22') return const Icon(Icons.home);
    if (submenu.menuId == '31') return const Icon(Icons.assignment_turned_in);
    if (submenu.menuId == '18') {
      return const Icon(Icons.sentiment_very_satisfied);
    }
    if (submenu.menuId == '14') return const Icon(Icons.accessibility);
    if (submenu.menuId == '21') return const Icon(Icons.add_to_photos);
    return null;
  }
}
