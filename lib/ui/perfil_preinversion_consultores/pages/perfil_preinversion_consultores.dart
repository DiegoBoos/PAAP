import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/perfil_preinversion_consultores/perfil_preinversion_consultores_bloc.dart';
import '../../../domain/cubits/consultor/consultor_cubit.dart';
import '../../../domain/cubits/menu/menu_cubit.dart';
import '../../../domain/entities/consultor_entity.dart';
import '../../perfil_preinversion/widgets/perfil_preinversion_drawer.dart';
import '../../utils/loading_page.dart';
import '../../utils/network_icon.dart';
import '../../utils/no_data_svg.dart';
import '../../utils/styles.dart';
import '../widgets/perfil_preinversion_consultores_rows.dart';

class PerfilPreInversionConsultoresPage extends StatelessWidget {
  const PerfilPreInversionConsultoresPage({super.key});

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
          BlocBuilder<PerfilPreInversionConsultoresBloc,
              PerfilPreInversionConsultoresState>(
            builder: (context, state) {
              if (state is PerfilPreInversionConsultoresLoaded) {
                return Card(
                    child: Column(children: const [
                  //TODO: Mostrar consultor de perfil preinversion o perfil???
                ]));
              }
              return Container();
            },
          ),
          BlocBuilder<ConsultorCubit, ConsultorState>(
            builder: (context, state) {
              if (state is ConsultoresLoading) {
                return const CustomCircularProgress(
                    alignment: Alignment.center);
              } else if (state is ConsultoresLoaded) {
                List<ConsultorEntity> consultores = state.consultoresLoaded!;
                if (consultores.isEmpty) {
                  return const SizedBox(
                      child:
                          Center(child: NoDataSvg(title: 'No hay resultados')));
                }
                return PerfilPreInversionConsultoresRows(
                    consultores: consultores,
                    subtitleStyle: Styles.subtitleStyle);
              }
              return Container();
            },
          ),
          const SizedBox(height: 30),
        ]));
  }
}
