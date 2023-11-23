import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/blocs/alianzas/alianzas_bloc.dart';
import '../../../domain/entities/v_alianza_entity.dart';
import '../../utils/sync_pages.dart';
import '../../utils/no_data_svg.dart';
import 'alianzas_rows.dart';

class AlianzasPage extends StatefulWidget {
  const AlianzasPage({super.key});

  @override
  State<AlianzasPage> createState() => _AlianzasPageState();
}

class _AlianzasPageState extends State<AlianzasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: BlocBuilder<AlianzasBloc, AlianzasState>(
          builder: (context, state) {
            if (state is AlianzasLoading) {
              return const CustomCircularProgress(alignment: Alignment.center);
            } else if (state is AlianzasLoaded) {
              List<VAlianzaEntity> alianzas = state.alianzasLoaded!;
              if (alianzas.isEmpty) {
                return const SizedBox(
                    child:
                        Center(child: NoDataSvg(title: 'No hay resultados')));
              }
              return AlianzasRows(alianzas: alianzas);
            }
            return Container();
          },
        ),
      ),
    );
  }
}
