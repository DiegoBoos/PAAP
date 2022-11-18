import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_exports.dart';
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
    final perfilPreInversionCofinanciadorCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.save),
            onPressed: () {
              perfilPreInversionCofinanciadorCubit.initState();
              Navigator.pushNamed(context, 'NewEditVCofinanciadorPreInversion');
            }),
        appBar: AppBar(centerTitle: true, leading: null, actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: NetworkIcon(),
          )
        ]),
        body: ListView(children: [
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text('COFINANCIADORES DEL PERFIL EN PREINVERSIÓN',
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
