import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/perfil_preinversion_costos_utp/perfil_preinversion_costos_utp_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_ingresos_utp/perfil_preinversion_ingresos_utp_cubit.dart';
import '../../../domain/entities/perfil_preinversion_plan_negocio_entity.dart';

class PerfilPreInversionPlanesNegociosRows extends StatelessWidget {
  const PerfilPreInversionPlanesNegociosRows(
      {Key? key,
      required this.perfilPreInversionPlanesNegocios,
      required this.subtitleStyle,
      required this.isCostosUPT,
      required this.isIngresosUPT})
      : super(key: key);

  final List<PerfilPreInversionPlanNegocioEntity>
      perfilPreInversionPlanesNegocios;
  final TextStyle subtitleStyle;
  final bool isCostosUPT;
  final bool isIngresosUPT;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.secondary),
          dividerThickness: 1,
          columnSpacing: 10,
          dataRowHeight: 150,
          columns: <DataColumn>[
            const DataColumn(
              label: Expanded(
                child: Text(''),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text('ID',
                    style: subtitleStyle.copyWith(color: Colors.white)),
              ),
            ),
            /*  DataColumn(
              label: Expanded(
                child:
                    Text('Actividad', style: subtitleStyle.copyWith(color: Colors.white)),
              ),
            ), */
            DataColumn(
              label: Expanded(
                child: Text('Rubro',
                    style: subtitleStyle.copyWith(color: Colors.white)),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text('Unidad',
                    style: subtitleStyle.copyWith(color: Colors.white)),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text('Año',
                    style: subtitleStyle.copyWith(color: Colors.white)),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text('Cantidad',
                    style: subtitleStyle.copyWith(color: Colors.white)),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text('Valor',
                    style: subtitleStyle.copyWith(color: Colors.white)),
              ),
            ),

            /* DataColumn(
              label: Expanded(
                child:
                    Text('Porcentaje %', style: subtitleStyle.copyWith(color: Colors.white)),
              ),
            ), */
          ],
          rows: List.generate(perfilPreInversionPlanesNegocios.length, (index) {
            PerfilPreInversionPlanNegocioEntity perfilPreInversionPlanNegocio =
                perfilPreInversionPlanesNegocios[index];

            return DataRow(cells: <DataCell>[
              DataCell(IconButton(
                  onPressed: () async {
                    if (isCostosUPT) {
                      final perfilPreInversionCostosUPTCubit =
                          BlocProvider.of<PerfilPreInversionCostosUPTCubit>(
                              context);
                      await perfilPreInversionCostosUPTCubit
                          .selectPerfilPreInversionCostosUPT(
                              perfilPreInversionPlanNegocio)
                          .whenComplete(() {
                        Navigator.pushNamed(
                            context, 'NewEditPerfilPreInversionCostosUPT');
                      });
                    } else if (isIngresosUPT) {
                      final perfilPreInversionIngresosUPTCubit =
                          BlocProvider.of<PerfilPreInversionIngresosUPTCubit>(
                              context);
                      await perfilPreInversionIngresosUPTCubit
                          .selectPerfilPreInversionIngresosUPT(
                              perfilPreInversionPlanNegocio)
                          .whenComplete(() {
                        Navigator.pushNamed(
                            context, 'NewEditPerfilPreInversionIngresosUPT');
                      });
                    }
                  },
                  icon: const Icon(
                    Icons.edit,
                  ))),
              DataCell(
                  Text(perfilPreInversionPlanNegocio.perfilPreInversionId)),
              //DataCell(Text(perfilPreInversionPlanNegocio.actividadFinanciera)),
              DataCell(Text(perfilPreInversionPlanNegocio.rubroId)),
              DataCell(Text(perfilPreInversionPlanNegocio.unidadId)),
              DataCell(Text(perfilPreInversionPlanNegocio.year)),
              DataCell(Text(perfilPreInversionPlanNegocio.cantidad)),
              DataCell(Text(perfilPreInversionPlanNegocio.valor)),
              //DataCell(Text(perfilPreInversionPlanNegocio.porcentaje)),
            ]);
          }),
        ),
      ),
    );
  }
}
