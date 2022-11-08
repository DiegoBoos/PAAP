import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/aliado/aliado_cubit.dart';
import '../../../domain/entities/aliado_entity.dart';

class AliadosRows extends StatelessWidget {
  const AliadosRows({
    Key? key,
    required this.aliados,
    required this.subtitleStyle,
  }) : super(key: key);

  final List<AliadoEntity> aliados;
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
        rows: List.generate(aliados.length, (index) {
          AliadoEntity aliado = aliados[index];

          return DataRow(cells: <DataCell>[
            DataCell(Text(aliado.aliadoId)),
            DataCell(Text(aliado.nombre)),
            DataCell(IconButton(
                onPressed: () {
                  final aliadoCubit = BlocProvider.of<AliadoCubit>(context);
                  aliadoCubit.getAliadoDB(aliado.aliadoId);
                  Navigator.pushNamed(context, 'VAliadoPreinversion',
                      arguments: aliado.aliadoId);
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
