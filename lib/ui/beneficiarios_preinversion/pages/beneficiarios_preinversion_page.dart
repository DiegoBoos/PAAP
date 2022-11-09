import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/beneficiarios_preinversion/beneficiarios_preinversion_bloc.dart';
import '../../../domain/entities/beneficiario_preinversion_entity.dart';
import '../../utils/loading_page.dart';
import '../../utils/network_icon.dart';
import '../../utils/no_data_svg.dart';
import '../../utils/styles.dart';
import '../widgets/beneficiarios_preinversion_rows.dart';

class BeneficiariosPreinversionPage extends StatelessWidget {
  const BeneficiariosPreinversionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.save),
            onPressed: () =>
                Navigator.pushNamed(context, 'VBeneficiarioPreInversion')),
        appBar: AppBar(
            title: const Text('Beneficiarios'),
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
            child: Text('BENEFICIARIOS', style: Styles.titleStyle),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text('Consulta', style: Styles.subtitleStyle),
          ),
          const SizedBox(height: 20),
          BlocBuilder<BeneficiariosPreinversionBloc,
              Beneficiariospreinversiontate>(
            builder: (context, state) {
              if (state is BeneficiariosPreinversionLoading) {
                return const CustomCircularProgress(
                    alignment: Alignment.center);
              } else if (state is BeneficiariosPreinversionLoaded) {
                List<BeneficiarioPreinversionEntity> beneficiariosPreinversion =
                    state.beneficiariosPreinversionLoaded!;
                if (beneficiariosPreinversion.isEmpty) {
                  return const SizedBox(
                      child:
                          Center(child: NoDataSvg(title: 'No hay resultados')));
                }
                return BeneficiariosPreinversionRows(
                    beneficiariosPreinversion: beneficiariosPreinversion,
                    subtitleStyle: Styles.subtitleStyle);
              }
              return const SizedBox();
            },
          ),
          const SizedBox(height: 30),
        ]));
  }
}
