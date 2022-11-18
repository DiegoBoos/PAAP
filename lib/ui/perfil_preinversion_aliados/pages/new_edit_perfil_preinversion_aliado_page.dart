import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_aliado/perfil_preinversion_aliado_cubit.dart';
import '../../perfil_preinversion/widgets/perfil_preinversion_drawer.dart';
import '../../utils/network_icon.dart';
import '../../utils/styles.dart';
import '../widgets/perfil_preinversion_aliado_form.dart';

class NewEditPerfilPreInversionAliadoPage extends StatefulWidget {
  const NewEditPerfilPreInversionAliadoPage({super.key});

  @override
  State<NewEditPerfilPreInversionAliadoPage> createState() =>
      _NewEditPerfilPreInversionAliadoPageState();
}

class _NewEditPerfilPreInversionAliadoPageState
    extends State<NewEditPerfilPreInversionAliadoPage> {
  @override
  Widget build(BuildContext context) {
    final menuCubit = BlocProvider.of<MenuCubit>(context);
    return Scaffold(
        drawer: BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            final menuHijo = menuCubit.preInversionMenuSorted(state.menus!);
            return PerfilPreInversionDrawer(
              menuHijo: menuHijo,
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
              child: BlocBuilder<PerfilPreInversionAliadoCubit,
                  PerfilPreInversionAliadoState>(
                builder: (context, state) {
                  if (state is PerfilPreInversionAliadoLoaded) {
                    return Text(
                        state.perfilPreInversionAliado!.aliadoId == '0'
                            ? 'Creación'
                            : 'Editar',
                        style: Styles.subtitleStyle);
                  }
                  return const SizedBox();
                },
              ),
            ),
            const PerfilPreInversionAliadoForm()
          ]),
        ));
  }
}
