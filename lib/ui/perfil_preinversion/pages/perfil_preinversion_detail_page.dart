import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/ui/utils/floating_buttons.dart';

import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../utils/network_icon.dart';
import '../../utils/styles.dart';
import '../widgets/perfil_preinversion_drawer.dart';
import '../widgets/perfil_preinversion_form.dart';

class PerfilPreInversionDetailPage extends StatefulWidget {
  const PerfilPreInversionDetailPage({super.key});

  @override
  State<PerfilPreInversionDetailPage> createState() =>
      _PerfilPreInversionDetailPageState();
}

class _PerfilPreInversionDetailPageState
    extends State<PerfilPreInversionDetailPage> {
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
        appBar: AppBar(title: const Text('Información Básica'), actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: NetworkIcon(),
          )
        ]),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView(children: const [
            SizedBox(height: 20),
            Text('PERFIL PREINVERSIÓN', style: Styles.titleStyle),
            SizedBox(height: 20),
            PerfilPreInversionForm(),
            SizedBox(height: 20),
            BackFloatingButton(),
          ]),
        ));
  }
}
