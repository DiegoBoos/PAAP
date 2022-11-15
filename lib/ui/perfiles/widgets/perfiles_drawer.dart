import 'package:flutter/material.dart';

import '../../../domain/entities/menu_entity.dart';

class PerfilesDrawer extends StatelessWidget {
  const PerfilesDrawer({Key? key, required this.menuHijo}) : super(key: key);
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
                leading: Icon(setIcon(submenu)),
                title: Text(submenu.nombre),
                onTap: () {
                  if (submenu.menuId == '12') {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    return;
                  }

                  Navigator.pushNamed(context, submenu.ruta);
                });
          },
        ));
  }

  IconData setIcon(MenuEntity submenu) {
    if (submenu.menuId == '12') return Icons.group;
    if (submenu.menuId == '22') return Icons.home;
    if (submenu.menuId == '31') return Icons.assignment_turned_in;

    return Icons.abc;
  }
}
