import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/perfil_preinversion_aliados/perfil_preinversion_aliados_bloc.dart';
import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../../domain/entities/perfil_preinversion_aliado_entity.dart';
import '../../perfil_preinversion/widgets/perfil_preinversion_drawer.dart';
import '../../utils/loading_page.dart';
import '../../utils/network_icon.dart';
import '../../utils/no_data_svg.dart';
import '../../utils/styles.dart';
import '../widgets/perfil_preinversion_aliados_rows.dart';

class PerfilPreInversionAliadosPage extends StatefulWidget {
  const PerfilPreInversionAliadosPage({super.key});

  @override
  State<PerfilPreInversionAliadosPage> createState() =>
      _PerfilPreInversionAliadosPageState();
}

class _PerfilPreInversionAliadosPageState
    extends State<PerfilPreInversionAliadosPage> {
  @override
  void initState() {
    super.initState();
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);
    final perfilPreInversionAliadosBloc =
        BlocProvider.of<PerfilPreInversionAliadosBloc>(context);
    perfilPreInversionAliadosBloc.add(GetPerfilPreInversionAliados(
        vPerfilPreInversionCubit
            .state.vPerfilPreInversion!.perfilPreInversionId));
  }

  @override
  Widget build(BuildContext context) {
    final menuCubit = BlocProvider.of<MenuCubit>(context);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.save),
            onPressed: () =>
                Navigator.pushNamed(context, 'NewEditAliadoPreInversion')),
        drawer: BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            final menuHijo = menuCubit.preInversionMenuSorted(state.menus!);
            return PerfilPreInversionDrawer(
              menuHijo: menuHijo,
            );
          },
        ),
        appBar: AppBar(
            title: const Text('PerfilPreInversionAliados'),
            actions: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: NetworkIcon(),
              )
            ]),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: ListView(children: [
              const SizedBox(height: 30),
              const Text('PerfilPreInversionAliados', style: Styles.titleStyle),
              const SizedBox(height: 20),
              const Text('Consulta', style: Styles.subtitleStyle),
              const SizedBox(height: 20),
              BlocBuilder<PerfilPreInversionAliadosBloc,
                  PerfilPreInversionAliadosState>(
                builder: (context, state) {
                  if (state is PerfilPreInversionAliadosLoading) {
                    return const CustomCircularProgress(
                        alignment: Alignment.center);
                  } else if (state is PerfilPreInversionAliadosLoaded) {
                    List<PerfilPreInversionAliadoEntity>
                        perfilPreInversionAliados =
                        state.perfilPreInversionAliadosLoaded!;
                    if (perfilPreInversionAliados.isEmpty) {
                      return const SizedBox(
                          child: Center(
                              child: NoDataSvg(title: 'No hay resultados')));
                    }
                    return PerfilPreInversionAliadosRows(
                        perfilPreInversionAliados: perfilPreInversionAliados,
                        subtitleStyle: Styles.subtitleStyle);
                  }
                  return const NoDataSvg(
                    title: 'No hay resultados',
                  );
                },
              ),
              const SizedBox(height: 30),
            ])));
  }
}
