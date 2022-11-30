import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/ui/alianzas/widgets/alianzas_drawer.dart';

import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../utils/network_icon.dart';
import '../../utils/styles.dart';

class AlianzaDetailPage extends StatelessWidget {
  const AlianzaDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final menuCubit = BlocProvider.of<MenuCubit>(context);

    return Scaffold(
      drawer: BlocBuilder<MenuCubit, MenuState>(
        builder: (context, state) {
          final menuHijo = menuCubit.alianzasMenuSorted(state.menus!);
          return AlianzasDrawer(
            menuHijo: menuHijo,
          );
        },
      ),
      appBar: AppBar(title: const Text('Detalle Alianza'), actions: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: NetworkIcon(),
        )
      ]),
      body: ListView(children: [
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('ALIANZA', style: Styles.titleStyle),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text('Información Básica', style: Styles.subtitleStyle),
        ),
      ]),
    );
  }
}
