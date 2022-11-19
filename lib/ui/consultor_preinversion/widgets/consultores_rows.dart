import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/consultor/consultor_cubit.dart';
import '../../../domain/entities/consultor_entity.dart';

class ConsultoresRows extends StatelessWidget {
  const ConsultoresRows({
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
        rows: List.generate(consultores.length, (index) {
          ConsultorEntity consultor = consultores[index];

          return DataRow(cells: <DataCell>[
            DataCell(Text(consultor.nombre1)),
            DataCell(IconButton(
                onPressed: () {
                  final consultorCubit =
                      BlocProvider.of<ConsultorCubit>(context);
                  consultorCubit.getConsultorDB(consultor.consultorId);
                  Navigator.pushNamed(
                      context, 'VAsignacionConsultorPreInversion',
                      arguments: consultor.consultorId);
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
