import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/alianza_beneficiarios/alianza_beneficiarios_bloc.dart';
import '../../../domain/entities/alianza_beneficiario_entity.dart';
import '../../utils/loading_page.dart';
import '../../utils/network_icon.dart';
import '../../utils/no_data_svg.dart';
import '../../utils/styles.dart';
import '../widgets/alianzas_beneficiarios_rows.dart';

class AlianzasBeneficiariossPage extends StatelessWidget {
  const AlianzasBeneficiariossPage({super.key});

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
          BlocBuilder<AlianzasBeneficiariosBloc, AlianzasBeneficiariosState>(
            builder: (context, state) {
              if (state is AlianzasBeneficiariosLoading) {
                return const CustomCircularProgress(
                    alignment: Alignment.center);
              } else if (state is AlianzasBeneficiariosLoaded) {
                List<AlianzaBeneficiarioEntity> alianzasBeneficiarios =
                    state.alianzasBeneficiariosLoaded!;
                if (alianzasBeneficiarios.isEmpty) {
                  return const SizedBox(
                      child:
                          Center(child: NoDataSvg(title: 'No hay resultados')));
                }
                return AlianzasBeneficiariosRows(
                    alianzasBeneficiarios: alianzasBeneficiarios,
                    subtitleStyle: Styles.subtitleStyle);
              }
              return Container();
            },
          ),
          const SizedBox(height: 30),
        ]));
  }
}
