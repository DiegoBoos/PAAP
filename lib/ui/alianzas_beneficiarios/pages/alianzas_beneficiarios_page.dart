import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/blocs/alianza_beneficiarios/alianza_beneficiarios_bloc.dart';
import '../../../ui/cubits/menu/menu_cubit.dart';
import '../../../ui/cubits/v_alianza/v_alianza_cubit.dart';
import '../../utils/sync_pages.dart';
import '../../utils/network_icon.dart';
import '../../utils/no_data_svg.dart';
import '../../utils/styles.dart';

import '../../alianzas/widgets/alianza_drawer.dart';
import '../widgets/alianzas_beneficiarios_rows.dart';

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
    alianzasBeneficiariosBloc
        .add(GetAlianzasBeneficiarios(vAlianzaCubit.state.vAlianza!.alianzaId));
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
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.save),
            onPressed: () =>
                Navigator.pushNamed(context, 'NewEditVBeneficiarioAlianza')),
        appBar: AppBar(title: const Text('Consulta'), actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: NetworkIcon(),
          )
        ]),
        body: ListView(children: [
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text('BENEFICIARIOS ALIANZA',
                style: Styles.titleStyle, textAlign: TextAlign.center),
          ),
          const SizedBox(height: 20),
          BlocBuilder<AlianzasBeneficiariosBloc, AlianzasBeneficiariosState>(
            builder: (context, state) {
              if (state is AlianzasBeneficiariosLoading) {
                return const CustomCircularProgress(
                    alignment: Alignment.center);
              }
              if (state is AlianzasBeneficiariosLoaded) {
                final alianzasBeneficiarios = state.alianzasBeneficiariosLoaded;
                if (alianzasBeneficiarios.isEmpty) {
                  return const SizedBox(
                      child:
                          Center(child: NoDataSvg(title: 'No hay resultados')));
                }
                return AlianzasBeneficiariosRows(
                    alianzasBeneficiarios: alianzasBeneficiarios,
                    subtitleStyle: Styles.subtitleStyle);
              }
              return Container();
            },
          ),
          const SizedBox(height: 30),
        ]));
  }
}
