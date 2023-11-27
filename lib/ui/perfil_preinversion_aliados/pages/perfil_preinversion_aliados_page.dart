import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/blocs/perfil_preinversion_aliados/perfil_preinversion_aliados_bloc.dart';
import '../../../ui/cubits/menu/menu_cubit.dart';
import '../../../ui/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../../domain/entities/perfil_preinversion_aliado_entity.dart';
import '../../perfil_preinversion/widgets/perfil_preinversion_drawer.dart';
import '../../utils/sync_pages.dart';
import '../../utils/network_icon.dart';
import '../../utils/no_data_svg.dart';
import 'perfil_preinversion_aliados_rows.dart';

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

    final perfilPreInversionId = vPerfilPreInversionCubit
        .state.vPerfilPreInversion!.perfilPreInversionId!;
    perfilPreInversionAliadosBloc
        .add(GetPerfilPreInversionAliados(perfilPreInversionId));
  }

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
        appBar: AppBar(title: const Text('Consulta'), actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: NetworkIcon(),
          )
        ]),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: BlocBuilder<PerfilPreInversionAliadosBloc,
              PerfilPreInversionAliadosState>(
            builder: (context, state) {
              if (state is PerfilPreInversionAliadosLoading) {
                return const CustomCircularProgress(
                    alignment: Alignment.center);
              } else if (state is PerfilPreInversionAliadosLoaded) {
                List<PerfilPreInversionAliadoEntity> perfilPreInversionAliados =
                    state.perfilPreInversionAliadosLoaded!;

                return PerfilPreInversionAliadosRows(
                  perfilPreInversionAliados: perfilPreInversionAliados,
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
