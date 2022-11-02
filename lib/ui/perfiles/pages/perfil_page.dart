import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/entities/menu_entity.dart';
import '../../utils/custom_drawer.dart';
import '../../utils/network_icon.dart';
import '../../utils/styles.dart';
import '../widgets/perfil_form.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final perfilId = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
        drawer: BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            final perfilesMenu = perfilesMenuSorted(state.menu!);
            return CustomDrawer(
              menuHijo: perfilesMenu,
              id: perfilId,
            );
          },
        ),
        appBar: AppBar(title: const Text('Detalle Perfil'), actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: NetworkIcon(),
          )
        ]),
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('PERFIL', style: Styles.titleStyle),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text('Información Básica', style: Styles.subtitleStyle),
            ),
            PerfilForm(perfilId)
          ]),
        ));
  }

  List<MenuEntity> perfilesMenuSorted(List<MenuEntity> menu) {
    final perfilesMenu = menu
        .where((menu) =>
            menu.menuId == '12' || menu.menuId == '22' || menu.menuId == '31')
        .toList();

    perfilesMenu.sort((a, b) {
      return a.orden.toLowerCase().compareTo(b.orden.toLowerCase());
    });
    return perfilesMenu;
  }
}
