import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/entities/v_perfil_preinversion_entity.dart';
import '../../preinversion/widgets/preinversion_form.dart';
import '../../utils/network_icon.dart';
import '../../utils/styles.dart';
import '../widgets/preinversion_drawer.dart';

class PerfilPreinversionDetailPage extends StatefulWidget {
  const PerfilPreinversionDetailPage({super.key});

  @override
  State<PerfilPreinversionDetailPage> createState() =>
      _PerfilPreinversionDetailPageState();
}

class _PerfilPreinversionDetailPageState
    extends State<PerfilPreinversionDetailPage> {
  @override
  Widget build(BuildContext context) {
    final perfilPreinversion =
        ModalRoute.of(context)?.settings.arguments as VPerfilPreinversionEntity;
    final menuCubit = BlocProvider.of<MenuCubit>(context);
    return Scaffold(
        drawer: BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            final menuHijo = menuCubit.preInversionMenuSorted(state.menus!);
            return PreinversionDrawer(
              menuHijo: menuHijo,
              perfilPreinversion: perfilPreinversion,
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
                  Text('PERFIL PREINVERSIÓN', style: Styles.titleStyle),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text('Información Básica', style: Styles.subtitleStyle),
            ),
            PreinversionForm(perfilPreinversion: perfilPreinversion)
          ]),
        ));
  }
}
