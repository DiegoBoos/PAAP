import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/aliados_preinversion/aliados_preinversion_bloc.dart';
import '../../../domain/entities/aliado_preinversion_entity.dart';
import '../../utils/loading_page.dart';
import '../../utils/network_icon.dart';
import '../../utils/no_data_svg.dart';
import '../../utils/styles.dart';
import '../widgets/aliados_preinversion_rows.dart';

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
            title: const Text('AliadosPreinversion'),
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
            child: Text('ALIADOSPREINVERSION', style: Styles.titleStyle),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text('Consulta', style: Styles.subtitleStyle),
          ),
          const SizedBox(height: 20),
          BlocBuilder<AliadosPreinversionBloc, AliadosPreinversionState>(
            builder: (context, state) {
              if (state is AliadosPreinversionLoading) {
                return const CustomCircularProgress(
                    alignment: Alignment.center);
              } else if (state is AliadosPreinversionLoaded) {
                List<AliadoPreinversionEntity> aliadosPreinversion =
                    state.aliadosPreinversionLoaded!;
                if (aliadosPreinversion.isEmpty) {
                  return const SizedBox(
                      child:
                          Center(child: NoDataSvg(title: 'No hay resultados')));
                }
                return AliadosPreinversionRows(
                    aliadosPreinversion: aliadosPreinversion,
                    subtitleStyle: Styles.subtitleStyle);
              }
              return const SizedBox();
            },
          ),
          const SizedBox(height: 30),
        ]));
  }
}
