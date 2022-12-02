import 'package:flutter/material.dart';

import '../../../domain/entities/perfil_preinversion_plan_negocio_entity.dart';

class PerfilPreInversionPlanesNegociosRows extends StatelessWidget {
  const PerfilPreInversionPlanesNegociosRows({
    Key? key,
    required this.perfilPreInversionPlanesNegocios,
    required this.subtitleStyle,
  }) : super(key: key);

  final List<PerfilPreInversionPlanNegocioEntity>
      perfilPreInversionPlanesNegocios;
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
      rows: List.generate(perfilPreInversionPlanesNegocios.length, (index) {
        PerfilPreInversionPlanNegocioEntity perfilPreInversionPlanNegocio =
            perfilPreInversionPlanesNegocios[index];

        return DataRow(cells: <DataCell>[
          DataCell(IconButton(
              onPressed: () async {
                /* final perfilPreInversionAliadoCubit =
                    BlocProvider.of<PerfilPreInversionAliadoCubit>(context);
                perfilPreInversionAliadoCubit
                    .selectAliadoPreinversion(perfilPreInversionAliado);

                final municipioCubit = BlocProvider.of<MunicipioCubit>(context);
                municipioCubit.getMunicipiosDB();

                final aliadoCubit = BlocProvider.of<AliadoCubit>(context);
                await aliadoCubit
                    .selectAliado(perfilPreInversionAliado.aliadoId)
                    .whenComplete(() {
                  Navigator.pushNamed(
                      context, 'NewEditPerfilPreInversionPlanesNegocios');
                }); */
              },
              icon: const Icon(
                Icons.keyboard_arrow_right,
              ))),
        ]);
      }),
    );
  }
}
