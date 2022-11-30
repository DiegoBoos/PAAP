import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/ui/modelo_financiero/widgets/ingresos_upt_form.dart';
import '../../../domain/cubits/actividad_financiera/actividad_financiera_cubit.dart';
import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/entities/actividad_financiera_entity.dart';
import '../../perfil_preinversion/widgets/perfil_preinversion_drawer.dart';
import '../../utils/network_icon.dart';
import '../widgets/costos_upt_form.dart';

class ModeloFinancieroPage extends StatefulWidget {
  const ModeloFinancieroPage({super.key});

  @override
  State<ModeloFinancieroPage> createState() => _ModeloFinancieroPageState();
}

class _ModeloFinancieroPageState extends State<ModeloFinancieroPage> {
  List<ActividadFinancieraEntity> actividadesFinancieras = [];

  @override
  void initState() {
    super.initState();
    final actividadFinancieraCubit =
        BlocProvider.of<ActividadFinancieraCubit>(context);

    loadActividadesFinancieras(actividadFinancieraCubit);
  }

  void loadActividadesFinancieras(
      ActividadFinancieraCubit actividadFinancieraCubit) async {
    await actividadFinancieraCubit.getActividadesFinancierasDB();

    if (actividadFinancieraCubit.state is ActividadesFinancierasLoaded) {
      actividadesFinancieras =
          actividadFinancieraCubit.state.actividadesFinancieras!;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final menuCubit = BlocProvider.of<MenuCubit>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('MODELO FINANCIERO'),
          centerTitle: true,
          leading: null,
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
        body: TabBarView(children: [
          CostosUPTForm(actividadesFinancieras),
          IngresosUPTForm(actividadesFinancieras),
        ]),
      ),
    );
  }
}
