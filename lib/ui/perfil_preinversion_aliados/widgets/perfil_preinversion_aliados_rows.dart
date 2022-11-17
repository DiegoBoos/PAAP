import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/aliado/aliado_cubit.dart';
import '../../../domain/entities/perfil_preinversion_aliado_entity.dart';

class PerfilPreInversionAliadosRows extends StatelessWidget {
  const PerfilPreInversionAliadosRows({
    Key? key,
    required this.perfilPreInversionAliados,
    required this.subtitleStyle,
  }) : super(key: key);

  final List<PerfilPreInversionAliadoEntity> perfilPreInversionAliados;
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
        rows: List.generate(perfilPreInversionAliados.length, (index) {
          PerfilPreInversionAliadoEntity perfilPreInversionAliado =
              perfilPreInversionAliados[index];

          return DataRow(cells: <DataCell>[
            DataCell(Text(perfilPreInversionAliado.aliadoId)),
            DataCell(IconButton(
                onPressed: () {
                  final aliadoCubit = BlocProvider.of<AliadoCubit>(context);
                  aliadoCubit.selectAliado(perfilPreInversionAliado);
                  Navigator.pushNamed(context, 'NewEditAliadoPreInversion',
                      arguments: perfilPreInversionAliado.aliadoId);
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
