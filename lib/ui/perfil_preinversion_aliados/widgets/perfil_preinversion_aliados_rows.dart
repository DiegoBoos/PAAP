import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paap/domain/cubits/perfil_preinversion_aliado/perfil_preinversion_aliado_cubit.dart';

import '../../../domain/cubits/aliado/aliado_cubit.dart';
import '../../../domain/cubits/municipio/municipio_cubit.dart';
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
    return DataTable(
      headingRowColor:
          MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
      dividerThickness: 1,
      columnSpacing: 10,
      dataRowHeight: 150,
      columns: <DataColumn>[
        DataColumn(
          label: Expanded(
            child:
                Text('ID', style: subtitleStyle.copyWith(color: Colors.white)),
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
              onPressed: () async {
                final perfilPreInversionAliadoCubit =
                    BlocProvider.of<PerfilPreInversionAliadoCubit>(context);
                perfilPreInversionAliadoCubit
                    .selectAliadoPreinversion(perfilPreInversionAliado);

                final municipioCubit = BlocProvider.of<MunicipioCubit>(context);
                municipioCubit.getMunicipiosDB();

                final aliadoCubit = BlocProvider.of<AliadoCubit>(context);
                await aliadoCubit
                    .selectAliado(perfilPreInversionAliado.aliadoId)
                    .whenComplete(() {
                  Navigator.pushNamed(context, 'NewEditAliadoPreInversion');
                });
              },
              icon: const Icon(
                Icons.keyboard_arrow_right,
              ))),
        ]);
      }),
    );
  }
}
