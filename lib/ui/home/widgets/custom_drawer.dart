import 'package:flutter/material.dart';
import 'expandable_menu.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      backgroundColor: Colors.white,
      child: ExpandableMenu(
        isSimpleList: true,
      ),
    );
  }
}
