import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/perfil/perfil_cubit.dart';
import '../../utils/loading_page.dart';

class PerfilCard extends StatefulWidget {
  const PerfilCard({super.key});

  @override
  State<PerfilCard> createState() => _PerfilCardState();
}

class _PerfilCardState extends State<PerfilCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PerfilCubit, PerfilState>(
      builder: (context, state) {
        if (state is PerfilLoading) {
          return const CustomCircularProgress(alignment: Alignment.center);
        } else if (state is PerfilLoaded) {
          return Card(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DataTable(
                      dividerThickness: 1,
                      columnSpacing: 40,
                      dataRowHeight: 150,
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'ID',
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Nombre del proyecto',
                            ),
                          ),
                        ),
                      ],
                      rows: [
                        DataRow(cells: <DataCell>[
                          DataCell(Text(state.perfilLoaded!.perfilId)),
                          DataCell(Text(state.perfilLoaded!.nombre)),
                        ])
                      ])));
        }
        return const SizedBox();
      },
    );
  }
}
