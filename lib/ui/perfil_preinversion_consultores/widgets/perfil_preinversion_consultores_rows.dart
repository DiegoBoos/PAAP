import 'package:flutter/material.dart';

import '../../../domain/entities/consultor_entity.dart';

class PerfilPreInversionConsultoresRows extends StatelessWidget {
  const PerfilPreInversionConsultoresRows({
    Key? key,
    required this.consultores,
    required this.subtitleStyle,
  }) : super(key: key);

  final List<ConsultorEntity> consultores;

  final TextStyle subtitleStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DataTable(
        headingRowColor:
            MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
        dividerThickness: 1,
        columns: <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Text('Consultor',
                  style: subtitleStyle.copyWith(color: Colors.white)),
            ),
          ),
          DataColumn(
            label: Expanded(
              child:
                  Text('', style: subtitleStyle.copyWith(color: Colors.white)),
            ),
          ),
        ],
        rows: List.generate(consultores.length, (index) {
          ConsultorEntity consultor = consultores[index];

          return DataRow(cells: <DataCell>[
            DataCell(SizedBox(
                child: Text(
                    '${consultor.nombre1} ${consultor.nombre2} ${consultor.apellido1} ${consultor.apellido2}'))),
            DataCell(IconButton(
                onPressed: () {
                  //TODO: asignar consultor
                },
                icon: const Icon(
                  Icons.person_add,
                  color: Colors.grey,
                ))),
          ]);
        }),
      ),
    );
  }
}
