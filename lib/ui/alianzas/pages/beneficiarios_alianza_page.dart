import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/beneficiarios_alianza/beneficiarios_alianza_bloc.dart';
import '../../../domain/entities/beneficiario_alianza_entity.dart';
import '../../utils/loading_page.dart';
import '../../utils/network_icon.dart';
import '../../utils/no_data_svg.dart';
import '../../utils/styles.dart';
import '../widgets/beneficiarios_alianza_rows.dart';

class BeneficiariosAlianzasPage extends StatelessWidget {
  const BeneficiariosAlianzasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.save),
            onPressed: () =>
                Navigator.pushNamed(context, 'VBeneficiarioAlianza')),
        appBar: AppBar(
            title: const Text('Beneficiarios Alianza'),
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
            child: Text('BENEFICIARIOS ALIANZA', style: Styles.titleStyle),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text('Consulta, Creación y Modificación',
                style: Styles.subtitleStyle),
          ),
          const SizedBox(height: 20),
          BlocBuilder<BeneficiariosAlianzaBloc, BeneficiariosAlianzaState>(
            builder: (context, state) {
              if (state is BeneficiariosAlianzaLoading) {
                return const CustomCircularProgress(
                    alignment: Alignment.center);
              } else if (state is BeneficiariosAlianzaLoaded) {
                List<BeneficiarioAlianzaEntity> beneficiariosAlianza =
                    state.beneficiariosAlianzaLoaded!;
                if (beneficiariosAlianza.isEmpty) {
                  return const SizedBox(
                      child:
                          Center(child: NoDataSvg(title: 'No hay resultados')));
                }
                return BeneficiariosAlianzaRows(
                    beneficiariosAlianzas: beneficiariosAlianza,
                    subtitleStyle: Styles.subtitleStyle);
              }
              return Container();
            },
          ),
          const SizedBox(height: 30),
        ]));
  }
}
