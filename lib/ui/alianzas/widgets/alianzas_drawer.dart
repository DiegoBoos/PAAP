import 'package:flutter/material.dart';

import '../../../domain/entities/menu_entity.dart';

class AlianzasDrawer extends StatelessWidget {
  const AlianzasDrawer({Key? key, required this.menuHijo}) : super(key: key);
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
                  if (submenu.menuId == '11') {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'tabs', (route) => false);
                    return;
                  }
                  Navigator.pushNamed(context, submenu.ruta);
                });
          },
        ));
  }

  IconData setIcon(MenuEntity submenu) {
    if (submenu.menuId == '11') return Icons.perm_contact_calendar;
    if (submenu.menuId == '43') return Icons.home;
    if (submenu.menuId == '44') return Icons.sentiment_very_satisfied;

    return Icons.abc;
  }
}
