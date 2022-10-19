import 'package:flutter/material.dart';

import '../../domain/entities/menu_entity.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key, required this.menuHijo}) : super(key: key);
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
                  Navigator.pushNamed(context, submenu.ruta);
                });
          },
        ));
  }

  IconData setIcon(MenuEntity submenu) {
    if (submenu.menuId == '22') return Icons.home;
    if (submenu.menuId == '31') return Icons.assignment_turned_in;

    if (submenu.menuId == '37') return Icons.home;
    if (submenu.menuId == '38') return Icons.sentiment_very_satisfied;
    if (submenu.menuId == '39') return Icons.accessibility;
    if (submenu.menuId == '40') return Icons.add_to_photos;
    if (submenu.menuId == '41') return Icons.touch_app;
    if (submenu.menuId == '2067') return Icons.attach_money;

    if (submenu.menuId == '43') return Icons.home;
    if (submenu.menuId == '44') return Icons.sentiment_very_satisfied;

    return Icons.abc;
  }
}
