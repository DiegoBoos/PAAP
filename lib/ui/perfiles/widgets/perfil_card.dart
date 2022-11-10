import 'package:flutter/material.dart';
import 'package:paap/domain/entities/v_perfil_entity.dart';

class PerfilCard extends StatelessWidget {
  const PerfilCard({super.key, required this.perfil});
  final VPerfilEntity perfil;

  @override
  Widget build(BuildContext context) {
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
                    DataCell(Text(perfil.perfilId)),
                    DataCell(Text(perfil.nombre)),
                  ])
                ])));
  }
}
