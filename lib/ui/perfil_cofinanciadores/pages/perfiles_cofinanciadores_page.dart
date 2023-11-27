import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/menu/menu_cubit.dart';
import '../../cubits/v_perfil/v_perfil_cubit.dart';
import '../../../domain/usecases/perfil_cofinanciador/perfil_cofinanciador_exports.dart';
import '../../perfiles/widgets/perfil_drawer.dart';
import '../../utils/sync_pages.dart';
import '../../utils/network_icon.dart';
import 'perfil_cofinanciador_rows.dart';

class PerfilCofinanciadoresPage extends StatefulWidget {
  const PerfilCofinanciadoresPage({super.key});

  @override
  State<PerfilCofinanciadoresPage> createState() =>
      _PerfilCofinanciadoresPageState();
}

class _PerfilCofinanciadoresPageState extends State<PerfilCofinanciadoresPage> {
  @override
  void initState() {
    super.initState();

    final perfilCofinanciadoresBloc =
        BlocProvider.of<PerfilCofinanciadoresBloc>(context);

    final vPerfilCubit = BlocProvider.of<VPerfilCubit>(context);
    perfilCofinanciadoresBloc
        .add(GetPerfilCofinanciadores(vPerfilCubit.state.vPerfil!.perfilId!));
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
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Consulta'),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: NetworkIcon(),
            )
          ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child:
            BlocBuilder<PerfilCofinanciadoresBloc, PerfilCofinanciadoresState>(
          builder: (context, state) {
            if (state is PerfilCofinanciadoresLoading) {
              return const CustomCircularProgress(alignment: Alignment.center);
            } else if (state is PerfilCofinanciadoresLoaded) {
              List<PerfilCofinanciadorEntity> perfilCofinanciadores =
                  state.perfilCofinanciadoresLoaded;

              return PerfilCofinanciadorRows(
                perfilCofinanciadores: perfilCofinanciadores,
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
