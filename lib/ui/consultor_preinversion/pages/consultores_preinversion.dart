import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/ui/perfil_preinversion/widgets/perfil_preinversion_drawer.dart';

import '../../../domain/blocs/consultores/consultores_bloc.dart';
import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/entities/consultor_entity.dart';
import '../../utils/loading_page.dart';
import '../../utils/network_icon.dart';
import '../../utils/no_data_svg.dart';
import '../../utils/styles.dart';
import '../widgets/consultores_rows.dart';

class ConsultoresPreInversionPage extends StatelessWidget {
  const ConsultoresPreInversionPage({super.key});

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
        appBar: AppBar(
            title: const Text(' Consultor'),
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
            child: Text('Asignación de consultor', style: Styles.titleStyle),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text('Consulta', style: Styles.subtitleStyle),
          ),
          const SizedBox(height: 20),
          BlocBuilder<ConsultoresBloc, ConsultoresState>(
            builder: (context, state) {
              if (state is ConsultoresLoading) {
                return const CustomCircularProgress(
                    alignment: Alignment.center);
              } else if (state is ConsultoresLoaded) {
                List<ConsultorEntity> consultor = state.consultoresLoaded!;
                if (consultor.isEmpty) {
                  return const SizedBox(
                      child:
                          Center(child: NoDataSvg(title: 'No hay resultados')));
                }
                return ConsultoresRows(
                    consultores: consultor,
                    subtitleStyle: Styles.subtitleStyle);
              }
              return const SizedBox();
            },
          ),
          const SizedBox(height: 30),
        ]));
  }
}
