import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../cubits/perfil_preinversion_costos_utp/perfil_preinversion_costos_utp_cubit.dart';
import '../../cubits/perfil_preinversion_ingresos_utp/perfil_preinversion_ingresos_utp_cubit.dart';
import '../../cubits/perfil_preinversion_precio/perfil_preinversion_precio_cubit.dart';
import '../../cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';
import '../../../domain/entities/v_perfil_preinversion_plan_negocio_entity.dart';

class PerfilPreInversionPlanNegociosTableSource extends DataTableSource {
  final BuildContext context;
  final List<VPerfilPreInversionPlanNegocioEntity>
      perfilPreInversionPlanNegocios;
  final String tipoMovimientoId;

  PerfilPreInversionPlanNegociosTableSource(
      this.context, this.perfilPreInversionPlanNegocios, this.tipoMovimientoId);

  @override
  DataRow getRow(int index) {
    final vPerfilPreInversionPlanNegocio =
        perfilPreInversionPlanNegocios[index];

    String? cantidad = vPerfilPreInversionPlanNegocio.cantidad;
    String? valor = vPerfilPreInversionPlanNegocio.valor;

    if (cantidad != null && cantidad != '') {
      cantidad =
          NumberFormat.currency(locale: 'en_US', decimalDigits: 0, symbol: "\$")
              .format(double.parse(cantidad));
    }

    if (valor != null && valor != '') {
      valor =
          NumberFormat.currency(locale: 'en_US', decimalDigits: 0, symbol: "\$")
              .format(double.parse(valor));
    }

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(vPerfilPreInversionPlanNegocio.valor!)),
        DataCell(TextButton(
          onPressed: () {
            if (tipoMovimientoId == '3') {
              final perfilPreInversionCostosUPTCubit =
                  BlocProvider.of<PerfilPreInversionCostosUPTCubit>(context);
              perfilPreInversionCostosUPTCubit
                  .selectPerfilPreInversionCostosUPT(
                      vPerfilPreInversionPlanNegocio);

              Navigator.pushNamed(context, 'NewEditPerfilPreInversionCostosUPT',
                  arguments: tipoMovimientoId);
            } else if (tipoMovimientoId == '2') {
              final vPerfilPreInversionCubit =
                  BlocProvider.of<VPerfilPreInversionCubit>(context);
              final perfilPreInversionPrecioCubit =
                  BlocProvider.of<PerfilPreInversionPrecioCubit>(context);
              final perfilPreInversionIngresosUPTCubit =
                  BlocProvider.of<PerfilPreInversionIngresosUPTCubit>(context);

              final perfilPreInversionId = vPerfilPreInversionCubit
                  .state.vPerfilPreInversion!.perfilPreInversionId!;

              perfilPreInversionPrecioCubit
                  .getPerfilPreInversionPrecioCubit(perfilPreInversionId);

              perfilPreInversionIngresosUPTCubit
                  .selectPerfilPreInversionIngresosUPT(
                      vPerfilPreInversionPlanNegocio);

              Navigator.pushNamed(
                  context, 'NewEditPerfilPreInversionIngresosUPT',
                  arguments: tipoMovimientoId);
            }
          },
          child: SizedBox(
            width: 200,
            child: Text(
              vPerfilPreInversionPlanNegocio.porcentaje ?? '',
            ),
          ),
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => perfilPreInversionPlanNegocios.length;

  @override
  int get selectedRowCount => 0;
}

class PerfilPreInversionPlanNegociosRows extends StatefulWidget {
  const PerfilPreInversionPlanNegociosRows({
    Key? key,
    required this.perfilPreInversionPlanNegocios,
    required this.tipoMovimientoId,
  }) : super(key: key);

  final List<VPerfilPreInversionPlanNegocioEntity>
      perfilPreInversionPlanNegocios;
  final String tipoMovimientoId;

  @override
  State<PerfilPreInversionPlanNegociosRows> createState() =>
      _PerfilPreInversionPlanNegociosRowsState();
}

class _PerfilPreInversionPlanNegociosRowsState
    extends State<PerfilPreInversionPlanNegociosRows> {
  List<VPerfilPreInversionPlanNegocioEntity>
      perfilPreInversionPlanNegociosFiltered = [];
  List<VPerfilPreInversionPlanNegocioEntity> allPerfilPreInversionPlanNegocios =
      [];

  @override
  void initState() {
    super.initState();
    allPerfilPreInversionPlanNegocios = widget.perfilPreInversionPlanNegocios;
    perfilPreInversionPlanNegociosFiltered = allPerfilPreInversionPlanNegocios;
  }

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      dataRowHeight: 250,
      header: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('PerfilPreInversionPlanNegocios'),
          IconButton(
              onPressed: () => Navigator.pushNamed(
                  context, 'NewEditPerfilPreInversionIngresosUPT'),
              icon: const Icon(Icons.add))
        ],
      ),
      rowsPerPage: 10, // Adjust as needed
      columns: const <DataColumn>[
        DataColumn(label: Text('Valor')),
        DataColumn(label: Text('Nombre')),
      ],
      source: PerfilPreInversionPlanNegociosTableSource(
          context, allPerfilPreInversionPlanNegocios, widget.tipoMovimientoId),
    );
  }
}
