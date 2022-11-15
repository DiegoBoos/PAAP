import 'package:flutter/material.dart';

import '../../../domain/entities/perfil_preinversion_cofinanciador_entity.dart';

class PerfilPreInversionCofinanciadoresRows extends StatelessWidget {
  const PerfilPreInversionCofinanciadoresRows({
    Key? key,
    required this.perfilPreInversionCofinanciadores,
    required this.subtitleStyle,
  }) : super(key: key);

  final List<PerfilPreInversionCofinanciadorEntity>
      perfilPreInversionCofinanciadores;
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
          const DataColumn(
            label: Expanded(
              child: Text(''),
            ),
          ),
        ],
        rows: List.generate(perfilPreInversionCofinanciadores.length, (index) {
          PerfilPreInversionCofinanciadorEntity
              perfilPreInversionCofinanciador =
              perfilPreInversionCofinanciadores[index];

          return DataRow(cells: <DataCell>[
            DataCell(Text(perfilPreInversionCofinanciador.cofinanciadorId)),
            DataCell(IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, 'VPerfilPreInversionCofinanciador',
                      arguments: perfilPreInversionCofinanciador);
                },
                icon: const Icon(
                  Icons.keyboard_arrow_right,
                ))),
          ]);
        }),
      ),
    );
  }
}
