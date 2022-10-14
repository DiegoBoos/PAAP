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
            final menuItem = menuHijo[index];

            return ListTile(
                leading: Icon(setIcon(menuItem.menuId)),
                title: Text(menuItem.nombre),
                onTap: () {
                  Navigator.pushNamed(context, menuItem.ruta);
                });
          },
        ));
  }

  IconData setIcon(String submenuId) {
    if (submenuId == '43') return Icons.home;
    if (submenuId == '44') return Icons.sentiment_very_satisfied;
    return Icons.abc;
  }
}
