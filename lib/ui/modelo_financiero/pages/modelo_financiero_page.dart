import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/domain/blocs/perfil_preinversion_planes_negocios/perfil_preinversion_planes_negocios_bloc.dart';

import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../perfil_preinversion/widgets/perfil_preinversion_drawer.dart';
import '../../utils/network_icon.dart';
import 'costos_upt_page.dart';
import 'ingresos_upt_page.dart';

class ModeloFinancieroPage extends StatefulWidget {
  const ModeloFinancieroPage({super.key});

  @override
  State<ModeloFinancieroPage> createState() => _ModeloFinancieroPageState();
}

class _ModeloFinancieroPageState extends State<ModeloFinancieroPage> {
  @override
  void initState() {
    super.initState();
    final perfilPreInversionPlanesNegociosBloc =
        BlocProvider.of<PerfilPreInversionPlanesNegociosBloc>(context);
    perfilPreInversionPlanesNegociosBloc
        .add(GetPerfilPreInversionPlanesNegocios());
  }

  @override
  Widget build(BuildContext context) {
    final menuCubit = BlocProvider.of<MenuCubit>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('MODELO FINANCIERO'),
            actions: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: NetworkIcon(),
              ),
            ],
            bottom: const TabBar(tabs: [
              Tab(icon: Text('COSTOS UPT')),
              Tab(icon: Text('INGRESOS UPT'))
            ]),
          ),
          drawer: BlocBuilder<MenuCubit, MenuState>(
            builder: (context, state) {
              final menuHijo = menuCubit.preInversionMenuSorted(state.menus!);
              return PerfilPreInversionDrawer(
                menuHijo: menuHijo,
              );
            },
          ),
          body: const TabBarView(children: [
            CostosUPTPage(),
            IngresosUPTPage(),
          ])),
    );
  }
}
