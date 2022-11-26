import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/v_alianza/v_alianza_cubit.dart';
import '../../../domain/entities/v_alianza_entity.dart';

class AlianzasRows extends StatelessWidget {
  const AlianzasRows({
    Key? key,
    required this.alianzas,
    required this.subtitleStyle,
  }) : super(key: key);

  final List<VAlianzaEntity> alianzas;

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
          VAlianzaEntity vAlianza = alianzas[index];

          return DataRow(cells: <DataCell>[
            DataCell(Text(vAlianza.alianzaId)),
            DataCell(Text(vAlianza.nombre)),
            DataCell(IconButton(
                onPressed: () {
                  BlocProvider.of<VAlianzaCubit>(context)
                      .selectVPerfilPreinversion(vAlianza);
                  Navigator.pushNamed(context, 'VAlianza');
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
