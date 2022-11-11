import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/aliado/aliado_cubit.dart';
import '../../../domain/entities/aliado_preinversion_entity.dart';

class AliadosPreinversionRows extends StatelessWidget {
  const AliadosPreinversionRows({
    Key? key,
    required this.aliadosPreinversion,
    required this.subtitleStyle,
  }) : super(key: key);

  final List<AliadoPreinversionEntity> aliadosPreinversion;
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
        rows: List.generate(aliadosPreinversion.length, (index) {
          AliadoPreinversionEntity aliadoPreinversion =
              aliadosPreinversion[index];

          return DataRow(cells: <DataCell>[
            DataCell(Text(aliadoPreinversion.aliadoId)),
            DataCell(IconButton(
                onPressed: () {
                  final aliadoCubit = BlocProvider.of<AliadoCubit>(context);
                  aliadoCubit.getAliadoDB(aliadoPreinversion.aliadoId);
                  Navigator.pushNamed(context, 'VAliadoPreinversion',
                      arguments: aliadoPreinversion.aliadoId);
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
