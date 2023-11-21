import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/aliado_entity.dart';
import '../../blocs/aliados/aliados_bloc.dart';
import '../../cubits/menu/menu_cubit.dart';
import '../../perfiles/widgets/perfil_drawer.dart';
import '../../utils/sync_pages.dart';
import '../../utils/network_icon.dart';
import '../../utils/no_data_svg.dart';
import '../widgets/aliados_rows.dart';

class AliadosPage extends StatefulWidget {
  const AliadosPage({super.key});

  @override
  State<AliadosPage> createState() => _AliadosPageState();
}

class _AliadosPageState extends State<AliadosPage> {
  @override
  void initState() {
    super.initState();

    final aliadosBloc = BlocProvider.of<AliadosBloc>(context);
    //TODO: buscar por perfilId?
    aliadosBloc.add(const GetAliados("1"));
  }

  @override
  Widget build(BuildContext context) {
    final menuCubit = BlocProvider.of<MenuCubit>(context);

    final aliadosBloc = BlocProvider.of<AliadosBloc>(context, listen: true);
    final aliados = aliadosBloc.state.aliados;

    return Scaffold(
        floatingActionButton: aliados != null && aliados.isEmpty
            ? FloatingActionButton(
                child: const Icon(Icons.save),
                onPressed: () =>
                    Navigator.pushNamed(context, 'NewEditAliadoPreInversion'))
            : null,
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
          child: BlocBuilder<AliadosBloc, AliadosState>(
            builder: (context, state) {
              if (state is AliadosLoading) {
                return const CustomCircularProgress(
                    alignment: Alignment.center);
              } else if (state is AliadosLoaded) {
                List<AliadoEntity> aliados = state.aliadosLoaded;
                if (aliados.isEmpty) {
                  return const SizedBox(
                      child:
                          Center(child: NoDataSvg(title: 'No hay resultados')));
                }
                return AliadosRows(
                  aliados: aliados,
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
