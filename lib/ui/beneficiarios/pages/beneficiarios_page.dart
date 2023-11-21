import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/beneficiarios/beneficiarios_bloc.dart';
import '../../cubits/menu/menu_cubit.dart';
import '../../cubits/v_perfil/v_perfil_cubit.dart';
import '../../perfiles/widgets/perfil_drawer.dart';
import '../../utils/sync_pages.dart';
import '../../utils/network_icon.dart';
import '../../utils/no_data_svg.dart';
import '../widgets/beneficiarios_rows.dart';

class BeneficiariosPage extends StatefulWidget {
  const BeneficiariosPage({super.key});

  @override
  State<BeneficiariosPage> createState() => _BeneficiariosPageState();
}

class _BeneficiariosPageState extends State<BeneficiariosPage> {
  @override
  void initState() {
    super.initState();
    final vPerfilCubit = BlocProvider.of<VPerfilCubit>(context);

    final beneficiariosBloc = BlocProvider.of<BeneficiariosBloc>(context);
    //TODO: buscar por perfilId?
    beneficiariosBloc
        .add(GetBeneficiarios(vPerfilCubit.state.vPerfil!.perfilId));
  }

  @override
  Widget build(BuildContext context) {
    final menuCubit = BlocProvider.of<MenuCubit>(context);

    return Scaffold(
      drawer: BlocBuilder<MenuCubit, MenuState>(
        builder: (context, state) {
          final menuHijo = menuCubit.perfilesMenuSorted(state.menus!);
          return PerfilDrawer(
            menuHijo: menuHijo,
          );
        },
      ),
      appBar: AppBar(title: const Text('Consulta'), actions: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: NetworkIcon(),
        )
      ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: BlocBuilder<BeneficiariosBloc, BeneficiariosState>(
          builder: (context, state) {
            if (state is BeneficiariosLoading) {
              return const CustomCircularProgress(alignment: Alignment.center);
            }
            if (state is BeneficiariosLoaded) {
              final beneficiarios = state.beneficiariosLoaded;
              if (beneficiarios.isEmpty) {
                return const SizedBox(
                    child:
                        Center(child: NoDataSvg(title: 'No hay resultados')));
              }
              return BeneficiariosRows(
                beneficiarios: beneficiarios,
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
