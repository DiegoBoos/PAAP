import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/perfil_beneficiarios/perfil_beneficiarios_bloc.dart';
import '../../cubits/menu/menu_cubit.dart';
import '../../cubits/v_perfil/v_perfil_cubit.dart';
import '../../perfiles/widgets/perfil_drawer.dart';
import '../../utils/sync_pages.dart';
import '../../utils/network_icon.dart';
import 'perfil_beneficiarios_rows.dart';

class PerfilBeneficiariosPage extends StatefulWidget {
  const PerfilBeneficiariosPage({super.key});

  @override
  State<PerfilBeneficiariosPage> createState() =>
      _PerfilBeneficiariosPageState();
}

class _PerfilBeneficiariosPageState extends State<PerfilBeneficiariosPage> {
  @override
  void initState() {
    super.initState();

    final vPerfilCubit = BlocProvider.of<VPerfilCubit>(context);
    final perfilBeneficiariosBloc =
        BlocProvider.of<PerfilBeneficiariosBloc>(context);

    final perfilId = vPerfilCubit.state.vPerfil!.perfilId!;
    perfilBeneficiariosBloc.add(GetPerfilBeneficiarios(perfilId));
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
        child: BlocBuilder<PerfilBeneficiariosBloc, PerfilBeneficiariosState>(
          builder: (context, state) {
            if (state is PerfilBeneficiariosLoading) {
              return const CustomCircularProgress(alignment: Alignment.center);
            }
            if (state is PerfilBeneficiariosLoaded) {
              final perfilBeneficiarios = state.perfilBeneficiariosLoaded;

              return PerfilBeneficiariosRows(
                perfilBeneficiarios: perfilBeneficiarios,
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
