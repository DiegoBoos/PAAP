import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/blocs/alianza_beneficiarios/alianza_beneficiarios_bloc.dart';
import '../../../ui/cubits/menu/menu_cubit.dart';
import '../../../ui/cubits/v_alianza/v_alianza_cubit.dart';
import '../../utils/sync_pages.dart';
import '../../utils/network_icon.dart';

import '../../alianzas/widgets/alianza_drawer.dart';
import 'alianzas_beneficiarios_rows.dart';

class AlianzasBeneficiariosPage extends StatefulWidget {
  const AlianzasBeneficiariosPage({super.key});

  @override
  State<AlianzasBeneficiariosPage> createState() =>
      _AlianzasBeneficiariosPageState();
}

class _AlianzasBeneficiariosPageState extends State<AlianzasBeneficiariosPage> {
  @override
  void initState() {
    super.initState();
    final vAlianzaCubit = BlocProvider.of<VAlianzaCubit>(context);

    final alianzasBeneficiariosBloc =
        BlocProvider.of<AlianzasBeneficiariosBloc>(context);
    alianzasBeneficiariosBloc.add(
        GetAlianzasBeneficiarios(vAlianzaCubit.state.vAlianza!.alianzaId!));
  }

  @override
  Widget build(BuildContext context) {
    final menuCubit = BlocProvider.of<MenuCubit>(context);

    return Scaffold(
      drawer: BlocBuilder<MenuCubit, MenuState>(
        builder: (context, state) {
          final menuHijo = menuCubit.alianzaMenuSorted(state.menus!);
          return AlianzaDrawer(
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
        child:
            BlocBuilder<AlianzasBeneficiariosBloc, AlianzasBeneficiariosState>(
          builder: (context, state) {
            if (state is AlianzasBeneficiariosLoading) {
              return const CustomCircularProgress(alignment: Alignment.center);
            }
            if (state is AlianzasBeneficiariosLoaded) {
              final alianzasBeneficiarios = state.alianzasBeneficiariosLoaded;

              return AlianzasBeneficiariosRows(
                alianzasBeneficiarios: alianzasBeneficiarios,
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
