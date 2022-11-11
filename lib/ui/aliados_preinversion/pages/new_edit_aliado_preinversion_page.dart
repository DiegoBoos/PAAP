import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/ui/aliados_preinversion/widgets/aliados_preinversion_drawer.dart';

import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/entities/aliado_preinversion_entity.dart';
import '../../utils/network_icon.dart';
import '../../utils/styles.dart';
import '../widgets/aliado_form.dart';

class NewEditAliadoPreinversionPage extends StatelessWidget {
  const NewEditAliadoPreinversionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final aliadoPreinversion =
        ModalRoute.of(context)?.settings.arguments as AliadoPreinversionEntity;
    final menuCubit = BlocProvider.of<MenuCubit>(context);
    return Scaffold(
        drawer: BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            final menuHijo = menuCubit.preInversionMenuSorted(state.menus!);
            return AliadosPreinversionDrawer(
              menuHijo: menuHijo,
              aliadoPreinversion: aliadoPreinversion,
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
                  aliadoPreinversion.aliadoId == '0' ? 'Creación' : 'Editar',
                  style: Styles.subtitleStyle),
            ),
            const AliadoPreinversionForm()
          ]),
        ));
  }
}
