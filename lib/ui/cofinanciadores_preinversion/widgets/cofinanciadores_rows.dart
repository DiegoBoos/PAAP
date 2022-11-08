import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/cofinanciador/cofinanciador_cubit.dart';
import '../../../domain/entities/cofinanciador_entity.dart';

class CofinanciadoresRows extends StatelessWidget {
  const CofinanciadoresRows({
    Key? key,
    required this.cofinanciadores,
    required this.subtitleStyle,
  }) : super(key: key);

  final List<CofinanciadorEntity> cofinanciadores;

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
        rows: List.generate(cofinanciadores.length, (index) {
          CofinanciadorEntity cofinanciador = cofinanciadores[index];

          return DataRow(cells: <DataCell>[
            DataCell(Text(cofinanciador.id)),
            DataCell(Text(cofinanciador.nombre)),
            DataCell(IconButton(
                onPressed: () {
                  final cofinanciadorCubit =
                      BlocProvider.of<CofinanciadorCubit>(context);
                  cofinanciadorCubit.getCofinanciadorDB(cofinanciador.id);
                  Navigator.pushNamed(context, 'VCofinanciadoresPreInversion',
                      arguments: cofinanciador.id);
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
