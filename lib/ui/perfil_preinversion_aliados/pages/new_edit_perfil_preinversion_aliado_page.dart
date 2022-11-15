import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/entities/v_perfil_preinversion_entity.dart';
import '../../utils/network_icon.dart';
import '../../utils/styles.dart';
import '../widgets/perfil_preinversion_aliado_form.dart';
import '../widgets/perfil_preinversion_aliado_drawer.dart';

class NewEditPerfilPreInversionAliadoPage extends StatelessWidget {
  const NewEditPerfilPreInversionAliadoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final perfilPreInversion =
        ModalRoute.of(context)?.settings.arguments as VPerfilPreInversionEntity;
    final menuCubit = BlocProvider.of<MenuCubit>(context);
    return Scaffold(
        drawer: BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            final menuHijo = menuCubit.preInversionMenuSorted(state.menus!);
            return PerfilPreInversionAliadoDrawer(
              menuHijo: menuHijo,
              perfilPreInversion: perfilPreInversion,
            );
          },
        ),
        appBar: AppBar(title: const Text('Detalle Aliado'), actions: const [
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
                  Text('ALIADO', style: Styles.titleStyle),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                  perfilPreInversion.perfilId == '0' ? 'Creación' : 'Editar',
                  style: Styles.subtitleStyle),
            ),
            const PerfilPreInversionAliadoForm()
          ]),
        ));
  }
}
