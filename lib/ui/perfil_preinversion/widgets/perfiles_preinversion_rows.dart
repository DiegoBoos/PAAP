import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../../domain/entities/v_perfil_preinversion_entity.dart';

class PerfilesPreInversionRows extends StatelessWidget {
  const PerfilesPreInversionRows({
    Key? key,
    required this.vPerfilesPreInversion,
    required this.subtitleStyle,
  }) : super(key: key);

  final List<VPerfilPreInversionEntity> vPerfilesPreInversion;
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
        rows: List.generate(vPerfilesPreInversion.length, (index) {
          VPerfilPreInversionEntity vPerfilPreInversion =
              vPerfilesPreInversion[index];

          return DataRow(cells: <DataCell>[
            DataCell(Text(vPerfilPreInversion.perfilPreInversionId)),
            DataCell(Text(vPerfilPreInversion.nombre)),
            DataCell(IconButton(
                onPressed: () {
                  BlocProvider.of<VPerfilPreInversionCubit>(context)
                      .selectVPerfilPreinversion(vPerfilPreInversion);
                  Navigator.pushNamed(
                    context,
                    'VPerfilPreInversion',
                  );
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
