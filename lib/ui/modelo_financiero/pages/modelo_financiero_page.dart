import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

const List<Tab> tabs = <Tab>[
  Tab(
    child: CostosUPTPage(),
  ),
  Tab(
    child: IngresosUPTPage(),
  )
];

class _ModeloFinancieroPageState extends State<ModeloFinancieroPage> {
  @override
  Widget build(BuildContext context) {
    final menuCubit = BlocProvider.of<MenuCubit>(context);

    return DefaultTabController(
        length: tabs.length,
        child: Builder(builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context)!;

          return Scaffold(
              floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    if (tabController.index == 0) {
                      Navigator.pushNamed(
                          context, 'NewEditPerfilPreInversionCostosUPT');
                    } else {
                      Navigator.pushNamed(
                          context, 'NewEditPerfilPreInversionIngresosUPT');
                    }
                  },
                  child: const Icon(Icons.add)),
              appBar: AppBar(
                title: const Text('MODELO FINANCIERO'),
                actions: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: NetworkIcon(),
                  ),
                ],
                bottom: const TabBar(tabs: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text('Costos UPT'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text('Ingresos UPT'),
                  ),
                ]),
              ),
              drawer: BlocBuilder<MenuCubit, MenuState>(
                builder: (context, state) {
                  final menuHijo =
                      menuCubit.preInversionMenuSorted(state.menus!);
                  return PerfilPreInversionDrawer(
                    menuHijo: menuHijo,
                  );
                },
              ),
              body: TabBarView(
                children: tabs.map((Tab tab) {
                  return tab;
                }).toList(),
              ));
        }));
  }
}
