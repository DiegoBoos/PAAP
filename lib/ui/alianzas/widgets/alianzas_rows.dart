import 'package:flutter/material.dart';

import '../../../domain/entities/alianza_entity.dart';

class AlianzasRows extends StatelessWidget {
  const AlianzasRows({
    Key? key,
    required this.alianzas,
    required this.subtitleStyle,
  }) : super(key: key);

  final List<AlianzaEntity> alianzas;

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
        rows: List.generate(alianzas.length, (index) {
          AlianzaEntity alianza = alianzas[index];

          return DataRow(cells: <DataCell>[
            DataCell(Text(alianza.alianzaId)),
            DataCell(Text(alianza.nombre)),
            DataCell(IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'VAlianza', arguments: alianza);
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
