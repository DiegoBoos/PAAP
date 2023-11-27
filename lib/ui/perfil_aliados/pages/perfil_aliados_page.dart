import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/ui/cubits/v_perfil/v_perfil_cubit.dart';

import '../../../domain/entities/perfil_aliado_entity.dart';
import '../../blocs/perfil_aliados/perfil_aliados_bloc.dart';
import '../../cubits/menu/menu_cubit.dart';
import '../../perfiles/widgets/perfil_drawer.dart';
import '../../utils/sync_pages.dart';
import '../../utils/network_icon.dart';
import '../../utils/no_data_svg.dart';
import 'perfil_aliados_rows.dart';

class PerfilAliadosPage extends StatefulWidget {
  const PerfilAliadosPage({super.key});

  @override
  State<PerfilAliadosPage> createState() => _PerfilAliadosPageState();
}

class _PerfilAliadosPageState extends State<PerfilAliadosPage> {
  @override
  void initState() {
    super.initState();

    final perfilAliadosBloc = BlocProvider.of<PerfilAliadosBloc>(context);
    final vPerfilCubit = BlocProvider.of<VPerfilCubit>(context);

    final perfilId = vPerfilCubit.state.vPerfil!.perfilId!;
    perfilAliadosBloc.add(GetPerfilAliados(perfilId));
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
          child: BlocBuilder<PerfilAliadosBloc, PerfilAliadosState>(
            builder: (context, state) {
              if (state is PerfilAliadosLoading) {
                return const CustomCircularProgress(
                    alignment: Alignment.center);
              } else if (state is PerfilAliadosLoaded) {
                List<PerfilAliadoEntity> perfilAliados =
                    state.perfilAliadosLoaded;

                return PerfilAliadosRows(
                  perfilAliados: perfilAliados,
                );
              }
              return const NoDataSvg(
                title: 'No hay resultados',
              );
            },
          ),
        ));
  }
}
