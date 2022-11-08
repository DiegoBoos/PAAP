import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/aliados/aliados_bloc.dart';
import '../../../domain/entities/aliado_entity.dart';
import '../../utils/loading_page.dart';
import '../../utils/network_icon.dart';
import '../../utils/no_data_svg.dart';
import '../../utils/styles.dart';
import '../widgets/aliados_rows.dart';

class AliadosPreinversionPage extends StatelessWidget {
  const AliadosPreinversionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.save),
            onPressed: () =>
                Navigator.pushNamed(context, 'VAliadoPreInversion')),
        appBar: AppBar(
            title: const Text('Aliados'),
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
            child: Text('ALIADOS', style: Styles.titleStyle),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text('Consulta', style: Styles.subtitleStyle),
          ),
          const SizedBox(height: 20),
          BlocBuilder<AliadosBloc, AliadosState>(
            builder: (context, state) {
              if (state is AliadosLoading) {
                return const CustomCircularProgress(
                    alignment: Alignment.center);
              } else if (state is AliadosLoaded) {
                List<AliadoEntity> aliados = state.aliadosLoaded!;
                if (aliados.isEmpty) {
                  return const SizedBox(
                      child:
                          Center(child: NoDataSvg(title: 'No hay resultados')));
                }
                return AliadosRows(
                    aliados: aliados, subtitleStyle: Styles.subtitleStyle);
              }
              return const SizedBox();
            },
          ),
          const SizedBox(height: 30),
        ]));
  }
}
