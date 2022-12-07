import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/network_icon.dart';
import '../../utils/styles.dart';
import '../widgets/perfil_form.dart';
import '../widgets/perfil_drawer.dart';

class PerfilDetailPage extends StatelessWidget {
  const PerfilDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final menuCubit = BlocProvider.of<MenuCubit>(context);

    return Scaffold(
        drawer: BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            final menuHijo = menuCubit.perfilesMenuSorted(state.menus!);
            return PerfilDrawer(
              menuHijo: menuHijo,
            );
          },
        ),
        appBar: AppBar(title: const Text('Detalle Perfil'), actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: NetworkIcon(),
          )
        ]),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView(children: const [
            SizedBox(height: 20),
            Text('PERFIL', style: Styles.titleStyle),
            SizedBox(height: 20),
            Text('Información Básica', style: Styles.subtitleStyle),
            SizedBox(height: 20),
            PerfilForm(),
            SizedBox(height: 20),
            BackFloatingButton()
          ]),
        ));
  }
}
