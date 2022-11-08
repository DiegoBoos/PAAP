import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/cofinanciadores/cofinanciadores_bloc.dart';
import '../../../domain/entities/cofinanciador_entity.dart';
import '../../utils/loading_page.dart';
import '../../utils/network_icon.dart';
import '../../utils/no_data_svg.dart';
import '../../utils/styles.dart';
import '../widgets/cofinanciadores_rows.dart';

class CofinanciadoresPreinversionPage extends StatelessWidget {
  const CofinanciadoresPreinversionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.save),
            onPressed: () =>
                Navigator.pushNamed(context, 'VCofinanciadorPreInversion')),
        appBar: AppBar(
            title: const Text('Cofinanciadores'),
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
            child: Text('Cofinanciadores', style: Styles.titleStyle),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text('Consulta', style: Styles.subtitleStyle),
          ),
          const SizedBox(height: 20),
          BlocBuilder<CofinanciadoresBloc, CofinanciadoresState>(
            builder: (context, state) {
              if (state is CofinanciadoresLoading) {
                return const CustomCircularProgress(
                    alignment: Alignment.center);
              } else if (state is CofinanciadoresLoaded) {
                List<CofinanciadorEntity> cofinanciadores =
                    state.cofinanciadoresLoaded!;
                if (cofinanciadores.isEmpty) {
                  return const SizedBox(
                      child:
                          Center(child: NoDataSvg(title: 'No hay resultados')));
                }
                return CofinanciadoresRows(
                    cofinanciadores: cofinanciadores,
                    subtitleStyle: Styles.subtitleStyle);
              }
              return const SizedBox();
            },
          ),
          const SizedBox(height: 30),
        ]));
  }
}
