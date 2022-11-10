import 'package:flutter/material.dart';

import '../../../domain/entities/menu_entity.dart';
import '../../../domain/entities/v_alianza_entity.dart';

class AlianzasDrawer extends StatelessWidget {
  const AlianzasDrawer(
      {Key? key, required this.menuHijo, required this.alianza})
      : super(key: key);
  final List<MenuEntity> menuHijo;
  final VAlianzaEntity alianza;
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
                  /*   if (submenu.menuId == '36') {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    return;
                  } */
                  if (submenu.menuId == '11') {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    return;
                  }
                  Navigator.pushNamed(context, submenu.ruta,
                      arguments: alianza);
                });
          },
        ));
  }

  IconData setIcon(MenuEntity submenu) {
/* 
    if (submenu.menuId == '36') return Icons.filter_center_focus;
    if (submenu.menuId == '37') return Icons.home;
    if (submenu.menuId == '38') return Icons.sentiment_very_satisfied;
    if (submenu.menuId == '39') return Icons.accessibility;
    if (submenu.menuId == '40') return Icons.add_to_photos;
    if (submenu.menuId == '41') return Icons.touch_app;
    if (submenu.menuId == '2067') return Icons.attach_money;
*/
    if (submenu.menuId == '11') return Icons.perm_contact_calendar;
    if (submenu.menuId == '43') return Icons.home;
    if (submenu.menuId == '44') return Icons.sentiment_very_satisfied;

    return Icons.abc;
  }
}
