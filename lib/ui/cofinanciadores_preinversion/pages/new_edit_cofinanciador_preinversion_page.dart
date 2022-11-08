import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../utils/custom_drawer.dart';
import '../../utils/network_icon.dart';
import '../../utils/styles.dart';
import '../widgets/cofinanciador_form.dart';

class NewEditCofinanciadorPreinversionPage extends StatelessWidget {
  const NewEditCofinanciadorPreinversionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cofinanciadorId =
        ModalRoute.of(context)?.settings.arguments as String;
    final menuCubit = BlocProvider.of<MenuCubit>(context);
    return Scaffold(
        drawer: BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            final menuHijo = menuCubit.preInversionMenuSorted(state.menus!);
            return CustomDrawer(
              menuHijo: menuHijo,
              id: cofinanciadorId,
            );
          },
        ),
        appBar:
            AppBar(title: const Text('Detalle Cofinanciador'), actions: const [
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
                  Text('Cofinanciador', style: Styles.titleStyle),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(cofinanciadorId == '0' ? 'Creación' : 'Editar',
                  style: Styles.subtitleStyle),
            ),
            CofinanciadorForm(cofinanciadorId)
          ]),
        ));
  }
}
