import 'package:flutter/material.dart';

import '../../../domain/entities/menu_entity.dart';
import '../../utils/custom_drawer.dart';

class PerfilesPage extends StatelessWidget {
  const PerfilesPage({super.key, required this.menuHijo});
  final List<MenuEntity> menuHijo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Perfiles')),
        drawer: CustomDrawer(menuHijo: menuHijo),
        body: Container());
  }
}
