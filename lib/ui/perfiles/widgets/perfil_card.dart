import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/cubits/v_perfil/v_perfil_cubit.dart';

class PerfilCard extends StatelessWidget {
  const PerfilCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VPerfilCubit, VPerfilState>(
      builder: (context, state) {
        if (state is VPerfilSelected) {
          return Card(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DataTable(
                      dividerThickness: 1,
                      columnSpacing: 40,
                      dataRowHeight: 200,
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
                          DataCell(Text(state.vPerfilSelected!.perfilId)),
                          DataCell(Text(state.vPerfilSelected!.nombre)),
                        ])
                      ])));
        }
        return Container();
      },
    );
  }
}
