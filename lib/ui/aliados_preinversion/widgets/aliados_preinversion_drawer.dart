import 'package:flutter/material.dart';

import '../../../domain/entities/aliado_preinversion_entity.dart';
import '../../../domain/entities/menu_entity.dart';

class AliadosPreinversionDrawer extends StatelessWidget {
  const AliadosPreinversionDrawer(
      {Key? key, required this.menuHijo, required this.aliadoPreinversion})
      : super(key: key);
  final List<MenuEntity> menuHijo;
  final AliadoPreinversionEntity aliadoPreinversion;
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
                  if (submenu.menuId == '36') {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    return;
                  }

                  Navigator.pushNamed(context, submenu.ruta,
                      arguments: aliadoPreinversion);
                });
          },
        ));
  }

  IconData setIcon(MenuEntity submenu) {
    if (submenu.menuId == '36') return Icons.filter_center_focus;
    if (submenu.menuId == '37') return Icons.home;
    if (submenu.menuId == '38') return Icons.sentiment_very_satisfied;
    if (submenu.menuId == '39') return Icons.accessibility;
    if (submenu.menuId == '40') return Icons.add_to_photos;
    if (submenu.menuId == '41') return Icons.touch_app;
    if (submenu.menuId == '2067') return Icons.attach_money;

    return Icons.abc;
  }
}
