import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/perfil_preinversion_beneficiarios/perfil_preinversion_beneficiarios_bloc.dart';
import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../perfil_preinversion/widgets/perfil_preinversion_drawer.dart';
import '../../utils/loading_page.dart';
import '../../utils/network_icon.dart';
import '../../utils/no_data_svg.dart';
import '../../utils/styles.dart';
import '../widgets/perfil_preinversion_beneficiarios_rows.dart';

class PerfilPreInversionBeneficiariosPage extends StatefulWidget {
  const PerfilPreInversionBeneficiariosPage({super.key});

  @override
  State<PerfilPreInversionBeneficiariosPage> createState() =>
      _PerfilPreInversionBeneficiariosPageState();
}

class _PerfilPreInversionBeneficiariosPageState
    extends State<PerfilPreInversionBeneficiariosPage> {
  @override
  void initState() {
    super.initState();
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);

    final perfilPreInversionBeneficiariosBloc =
        BlocProvider.of<PerfilPreInversionBeneficiariosBloc>(context);
    perfilPreInversionBeneficiariosBloc.add(GetPerfilPreInversionBeneficiarios(
        vPerfilPreInversionCubit
            .state.vPerfilPreInversion!.perfilPreInversionId));
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
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.save),
            onPressed: () => Navigator.pushNamed(
                context, 'NewEditVBeneficiarioPreInversion')),
        appBar: AppBar(
            title: const Text('Beneficiarios'),
            centerTitle: true,
            leading: null,
            actions: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: NetworkIcon(),
              )
            ]),
        body: ListView(children: [
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text('BENEFICIARIOS', style: Styles.titleStyle),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text('Consulta', style: Styles.subtitleStyle),
          ),
          const SizedBox(height: 20),
          BlocBuilder<PerfilPreInversionBeneficiariosBloc,
              PerfilPreInversionBeneficiariosState>(
            builder: (context, state) {
              if (state is PerfilPreInversionBeneficiariosLoading) {
                return const CustomCircularProgress(
                    alignment: Alignment.center);
              }
              if (state is PerfilPreInversionBeneficiariosLoaded) {
                final perfilPreInversionBeneficiarios =
                    state.perfilPreInversionBeneficiariosLoaded;
                if (perfilPreInversionBeneficiarios.isEmpty) {
                  return const SizedBox(
                      child:
                          Center(child: NoDataSvg(title: 'No hay resultados')));
                }
                return PerfilPreInversionBeneficiariosRows(
                    perfilPreInversionBeneficiarios:
                        perfilPreInversionBeneficiarios,
                    subtitleStyle: Styles.subtitleStyle);
              }
              return Container();
            },
          ),
          const SizedBox(height: 30),
        ]));
  }
}
