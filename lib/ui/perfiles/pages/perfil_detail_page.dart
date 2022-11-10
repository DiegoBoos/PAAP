import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/entities/v_perfil_entity.dart';
import '../../utils/network_icon.dart';
import '../../utils/styles.dart';
import '../widgets/perfil_form.dart';
import '../widgets/perfiles_drawer.dart';

class PerfilDetailPage extends StatelessWidget {
  const PerfilDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final perfil = ModalRoute.of(context)?.settings.arguments as VPerfilEntity;
    final menuCubit = BlocProvider.of<MenuCubit>(context);

    return Scaffold(
        drawer: BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            final menuHijo = menuCubit.perfilesMenuSorted(state.menus!);
            return PerfilesDrawer(
              menuHijo: menuHijo,
              perfil: perfil,
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
            PerfilForm(perfil: perfil)
          ]),
        ));
  }
}
