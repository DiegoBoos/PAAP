import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/ui/perfil_preinversion/widgets/perfil_preinversion_drawer.dart';

import '../../../domain/blocs/perfil_preinversion_beneficiarios/perfil_preinversion_beneficiarios_bloc.dart';
import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/entities/perfil_preinversion_beneficiario_entity.dart';
import '../../utils/loading_page.dart';
import '../../utils/network_icon.dart';
import '../../utils/no_data_svg.dart';
import '../../utils/styles.dart';
import '../widgets/perfil_preinversion_beneficiarios_rows.dart';

class PerfilPreInversionBeneficiariosPage extends StatelessWidget {
  const PerfilPreInversionBeneficiariosPage({super.key});

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
              PerfilPreInversionBeneficiariostate>(
            builder: (context, state) {
              if (state is PerfilPreInversionBeneficiariosLoading) {
                return const CustomCircularProgress(
                    alignment: Alignment.center);
              } else if (state is PerfilPreInversionBeneficiariosLoaded) {
                List<PerfilPreInversionBeneficiarioEntity>
                    perfilPreInversionBeneficiarios =
                    state.perfilPreInversionBeneficiariosLoaded!;
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
