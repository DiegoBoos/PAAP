import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/ui/alianzas/widgets/alianza_drawer.dart';

import '../../../ui/cubits/menu/menu_cubit.dart';
import '../../utils/floating_buttons.dart';
import '../../utils/network_icon.dart';
import '../../utils/styles.dart';
import '../widgets/alianza_form.dart';

class AlianzaDetailPage extends StatelessWidget {
  const AlianzaDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final menuCubit = BlocProvider.of<MenuCubit>(context);

    return Scaffold(
        drawer: BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            final menuHijo = menuCubit.alianzaMenuSorted(state.menus!);
            return AlianzaDrawer(
              menuHijo: menuHijo,
            );
          },
        ),
        appBar: AppBar(
            title: const Text('Información Básica', style: Styles.titleStyle),
            actions: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: NetworkIcon(),
              )
            ]),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView(children: const [
            SizedBox(height: 20),
            Text('Alianza', style: Styles.titleStyle),
            SizedBox(height: 20),
            AlianzaForm(),
            SizedBox(height: 20),
            BackFloatingButton(),
          ]),
        ));
  }
}
