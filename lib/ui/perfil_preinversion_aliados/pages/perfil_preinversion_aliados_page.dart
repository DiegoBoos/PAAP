import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/perfil_preinversion_aliados/perfil_preinversion_aliados_bloc.dart';
import '../../../domain/entities/perfil_preinversion_aliado_entity.dart';
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
    final perfilPreInversionAliadosBloc =
        BlocProvider.of<PerfilPreInversionAliadosBloc>(context);
    perfilPreInversionAliadosBloc.add(GetPerfilPreInversionAliados());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.save),
            onPressed: () => Navigator.pushNamed(
                context, 'NewEditAliadoPreInversion', arguments: '0')),
        appBar: AppBar(
            title: const Text('PerfilPreInversionAliados'),
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
            child: Text('PerfilPreInversionAliados', style: Styles.titleStyle),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text('Consulta', style: Styles.subtitleStyle),
          ),
          const SizedBox(height: 20),
          BlocBuilder<PerfilPreInversionAliadosBloc,
              PerfilPreInversionAliadosState>(
            builder: (context, state) {
              if (state is PerfilPreInversionAliadosLoading) {
                return const CustomCircularProgress(
                    alignment: Alignment.center);
              } else if (state is PerfilPreInversionAliadosLoaded) {
                List<PerfilPreInversionAliadoEntity> perfilPreInversionAliados =
                    state.perfilPreInversionAliadosLoaded!;
                if (perfilPreInversionAliados.isEmpty) {
                  return const SizedBox(
                      child:
                          Center(child: NoDataSvg(title: 'No hay resultados')));
                }
                return PerfilPreInversionAliadosRows(
                    perfilPreInversionAliados: perfilPreInversionAliados,
                    subtitleStyle: Styles.subtitleStyle);
              }
              return const SizedBox();
            },
          ),
          const SizedBox(height: 30),
        ]));
  }
}
