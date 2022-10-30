import 'package:flutter/material.dart';

import '../../../domain/entities/perfil_entity.dart';

class PerfilesRows extends StatelessWidget {
  const PerfilesRows({
    Key? key,
    required this.perfiles,
    required this.subtitleStyle,
  }) : super(key: key);

  final List<PerfilEntity> perfiles;
  final TextStyle subtitleStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DataTable(
        headingRowColor:
            MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
        dividerThickness: 1,
        columnSpacing: 10,
        dataRowHeight: 150,
        columns: <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Text('ID',
                  style: subtitleStyle.copyWith(color: Colors.white)),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text('Nombre',
                  style: subtitleStyle.copyWith(color: Colors.white)),
            ),
          ),
          const DataColumn(
            label: Expanded(
              child: Text(''),
            ),
          ),
        ],
        rows: List.generate(perfiles.length, (index) {
          PerfilEntity perfil = perfiles[index];

          return DataRow(cells: <DataCell>[
            DataCell(Text(perfil.perfilId)),
            DataCell(Text(perfil.nombre)),
            DataCell(IconButton(
                onPressed: () => Navigator.pushNamed(context, 'VPerfil',
                    arguments: perfil.perfilId),
                icon: const Icon(
                  Icons.keyboard_arrow_right,
                ))),
          ]);
        }),
      ),
    );
  }
}
