import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/perfil_preinversion_costos_utp/perfil_preinversion_costos_utp_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_ingresos_utp/perfil_preinversion_ingresos_utp_cubit.dart';
import '../../../domain/cubits/perfil_preinversion_precio/perfil_preinversion_precio_cubit.dart';
import '../../../domain/cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../../domain/entities/v_perfil_preinversion_plan_negocio_entity.dart';

class PerfilPreInversionPlanesNegociosRows extends StatelessWidget {
  const PerfilPreInversionPlanesNegociosRows(
      {Key? key,
      required this.vPerfilesPreInversionesPlanNegocios,
      required this.subtitleStyle,
      required this.tipoMovimiento})
      : super(key: key);

  final List<VPerfilPreInversionPlanNegocioEntity>
      vPerfilesPreInversionesPlanNegocios;
  final TextStyle subtitleStyle;
  final String tipoMovimiento;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
            DataColumn(
              label: Expanded(
                child: Text('Actividad',
                    style: subtitleStyle.copyWith(color: Colors.white)),
              ),
            ),
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
            DataColumn(
              label: Expanded(
                child: Text('Porcentaje %',
                    style: subtitleStyle.copyWith(color: Colors.white)),
              ),
            ),
          ],
          rows: List.generate(vPerfilesPreInversionesPlanNegocios.length,
              (index) {
            VPerfilPreInversionPlanNegocioEntity
                vPerfilPreInversionPlanNegocio =
                vPerfilesPreInversionesPlanNegocios[index];

            return DataRow(cells: <DataCell>[
              DataCell(IconButton(
                  onPressed: () {
                    if (tipoMovimiento == '3') {
                      final perfilPreInversionCostosUPTCubit =
                          BlocProvider.of<PerfilPreInversionCostosUPTCubit>(
                              context);
                      perfilPreInversionCostosUPTCubit
                          .selectPerfilPreInversionCostosUPT(
                              vPerfilPreInversionPlanNegocio);

                      Navigator.pushNamed(
                          context, 'NewEditPerfilPreInversionCostosUPT');
                    } else if (tipoMovimiento == '2') {
                      final vPerfilPreInversionCubit =
                          BlocProvider.of<VPerfilPreInversionCubit>(context);
                      final perfilPreInversionPrecioCubit =
                          BlocProvider.of<PerfilPreInversionPrecioCubit>(
                              context);
                      final perfilPreInversionIngresosUPTCubit =
                          BlocProvider.of<PerfilPreInversionIngresosUPTCubit>(
                              context);

                      perfilPreInversionPrecioCubit
                          .getPerfilPreInversionPrecioCubit(
                              vPerfilPreInversionCubit.state
                                  .vPerfilPreInversion!.perfilPreInversionId);

                      perfilPreInversionIngresosUPTCubit
                          .selectPerfilPreInversionIngresosUPT(
                              vPerfilPreInversionPlanNegocio);

                      Navigator.pushNamed(
                          context, 'NewEditPerfilPreInversionIngresosUPT');
                    }
                  },
                  icon: const Icon(
                    Icons.edit,
                  ))),
              DataCell(Text(vPerfilPreInversionPlanNegocio.rubroId)),
              DataCell(
                  Text(vPerfilPreInversionPlanNegocio.actividadFinanciera)),
              DataCell(Text(vPerfilPreInversionPlanNegocio.rubro)),
              DataCell(Text(vPerfilPreInversionPlanNegocio.unidad)),
              DataCell(Text(vPerfilPreInversionPlanNegocio.year)),
              DataCell(Text(vPerfilPreInversionPlanNegocio.cantidad)),
              DataCell(Text(vPerfilPreInversionPlanNegocio.valor)),
              DataCell(Text(vPerfilPreInversionPlanNegocio.porcentaje)),
            ]);
          }),
        ),
      ),
    );
  }
}
