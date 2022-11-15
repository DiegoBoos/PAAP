import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/perfil_preinversion_cofinanciadores/perfil_preinversion_cofinanciadores_bloc.dart';
import '../../../domain/entities/perfil_preinversion_cofinanciador_entity.dart';
import '../../utils/loading_page.dart';
import '../../utils/network_icon.dart';
import '../../utils/no_data_svg.dart';
import '../../utils/styles.dart';
import '../widgets/perfil_preinversion_cofinanciador_rows.dart';

class PerfilPreInversionCofinanciadoresPage extends StatefulWidget {
  const PerfilPreInversionCofinanciadoresPage({super.key});

  @override
  State<PerfilPreInversionCofinanciadoresPage> createState() =>
      _PerfilPreInversionCofinanciadoresPageState();
}

class _PerfilPreInversionCofinanciadoresPageState
    extends State<PerfilPreInversionCofinanciadoresPage> {
  @override
  void initState() {
    super.initState();
    final perfilPreInversionCofinanciadoresBloc =
        BlocProvider.of<PerfilPreInversionCofinanciadoresBloc>(context);
    perfilPreInversionCofinanciadoresBloc
        .add(GetPerfilPreInversionCofinanciadores());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.save),
            onPressed: () => Navigator.pushNamed(
                context, 'VPerfilPreInversionCofinanciador')),
        appBar: AppBar(
            title: const Text('PerfilPreInversionCofinanciadores'),
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
            child: Text('PerfilPreInversionCofinanciadores',
                style: Styles.titleStyle),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text('Consulta', style: Styles.subtitleStyle),
          ),
          const SizedBox(height: 20),
          BlocBuilder<PerfilPreInversionCofinanciadoresBloc,
              PerfilPreInversionCofinanciadoresState>(
            builder: (context, state) {
              if (state is PerfilPreInversionCofinanciadoresLoading) {
                return const CustomCircularProgress(
                    alignment: Alignment.center);
              } else if (state is PerfilPreInversionCofinanciadoresLoaded) {
                List<PerfilPreInversionCofinanciadorEntity>
                    perfilPreInversionCofinanciadores =
                    state.perfilPreInversionCofinanciadoresLoaded!;
                if (perfilPreInversionCofinanciadores.isEmpty) {
                  return const SizedBox(
                      child:
                          Center(child: NoDataSvg(title: 'No hay resultados')));
                }
                return PerfilPreInversionCofinanciadoresRows(
                    perfilPreInversionCofinanciadores:
                        perfilPreInversionCofinanciadores,
                    subtitleStyle: Styles.subtitleStyle);
              }
              return const SizedBox();
            },
          ),
          const SizedBox(height: 30),
        ]));
  }
}
