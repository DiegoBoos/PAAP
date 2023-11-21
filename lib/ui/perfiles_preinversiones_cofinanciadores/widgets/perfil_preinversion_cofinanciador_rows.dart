import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/perfil_preinversion_cofinanciador_entity.dart';
import '../../blocs/perfil_preinversion_cofinanciador_actividades_financieras/perfil_preinversion_cofinanciador_actividades_financieras_bloc.dart';
import '../../blocs/perfil_preinversion_cofinanciador_desembolsos/perfil_preinversion_cofinanciador_desembolsos_bloc.dart';
import '../../blocs/perfil_preinversion_cofinanciador_rubros/perfil_preinversion_cofinanciador_rubros_bloc.dart';
import '../../cubits/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_cubit.dart';
import '../../cubits/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_cubit.dart';
import '../../cubits/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_cubit.dart';
import '../../cubits/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_cubit.dart';
import '../../cubits/v_perfil_preinversion/v_perfil_preinversion_cubit.dart';

class PerfilPreInversionCofinanciadoresTableSource extends DataTableSource {
  final BuildContext context;
  final List<PerfilPreInversionCofinanciadorEntity>
      perfilPreInversionCofinanciadores;

  PerfilPreInversionCofinanciadoresTableSource(
      this.context, this.perfilPreInversionCofinanciadores);

  @override
  DataRow getRow(int index) {
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);

    final perfilPreInversionCofinanciadorCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(context);

    final perfilPreInversionCofinanciadorDesembolsoCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorDesembolsoCubit>(
      context,
    );

    final perfilPreInversionCofinanciadorActividadFinancieraCubit = BlocProvider
        .of<PerfilPreInversionCofinanciadorActividadFinancieraCubit>(
      context,
    );

    final perfilPreInversionCofinanciadorRubroCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorRubroCubit>(
      context,
    );

    final perfilPreInversionCofinanciador =
        perfilPreInversionCofinanciadores[index];

    final monto =
        NumberFormat.currency(locale: 'en_US', decimalDigits: 0, symbol: "\$")
            .format(double.parse(perfilPreInversionCofinanciador.monto));

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(perfilPreInversionCofinanciador.cofinanciadorId!)),
        DataCell(TextButton(
            onPressed: perfilPreInversionCofinanciador.correo == 'TOTAL'
                ? null
                : () async {
                    final navigator = Navigator.of(context);

                    final vPerfilPreInversionId = vPerfilPreInversionCubit
                        .state.vPerfilPreInversion!.perfilPreInversionId;

                    final cofinanciadorId =
                        perfilPreInversionCofinanciador.cofinanciadorId!;

                    perfilPreInversionCofinanciadorCubit
                        .changeCofinanciador(cofinanciadorId);

                    perfilPreInversionCofinanciadorCubit
                        .selectPerfilPreInversionCofinanciador(
                            perfilPreInversionCofinanciador);

                    perfilPreInversionCofinanciadorDesembolsoCubit
                        .getPerfilPreInversionCofinanciadorDesembolso(
                            vPerfilPreInversionId, cofinanciadorId);

                    perfilPreInversionCofinanciadorActividadFinancieraCubit
                        .getPerfilPreInversionCofinanciadorActividadFinanciera(
                      vPerfilPreInversionId,
                      cofinanciadorId,
                    );

                    perfilPreInversionCofinanciadorRubroCubit
                        .getPerfilPreInversionCofinanciadorRubro(
                      vPerfilPreInversionId,
                      cofinanciadorId,
                    );

                    navigator.pushNamed('NewEditVCofinanciadorPreInversion',
                        arguments: perfilPreInversionCofinanciador);
                  },
            child: Text(perfilPreInversionCofinanciador.nombre!))),
        DataCell(Text(monto)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => perfilPreInversionCofinanciadores.length;

  @override
  int get selectedRowCount => 0;
}

class PerfilPreInversionCofinanciadorRows extends StatefulWidget {
  const PerfilPreInversionCofinanciadorRows({
    Key? key,
    required this.perfilPreInversionCofinanciadores,
  }) : super(key: key);

  final List<PerfilPreInversionCofinanciadorEntity>
      perfilPreInversionCofinanciadores;

  @override
  State<PerfilPreInversionCofinanciadorRows> createState() =>
      _PerfilPreInversionCofinanciadorRowsState();
}

class _PerfilPreInversionCofinanciadorRowsState
    extends State<PerfilPreInversionCofinanciadorRows> {
  List<PerfilPreInversionCofinanciadorEntity>
      perfilPreInversionCofinanciadoresFiltered = [];
  List<PerfilPreInversionCofinanciadorEntity>
      allPerfilPreInversionCofinanciadores = [];

  @override
  void initState() {
    super.initState();
    allPerfilPreInversionCofinanciadores =
        widget.perfilPreInversionCofinanciadores;
    perfilPreInversionCofinanciadoresFiltered =
        allPerfilPreInversionCofinanciadores;
  }

  void _buscar(String query) {
    final lowerCaseQuery = query.toLowerCase();
    final perfilPreInversionCofinanciadores =
        allPerfilPreInversionCofinanciadores
            .where((perfilPreInversionCofinanciador) {
      return perfilPreInversionCofinanciador.nombre!
          .toLowerCase()
          .contains(lowerCaseQuery);
    }).toList();

    setState(() {
      perfilPreInversionCofinanciadoresFiltered =
          perfilPreInversionCofinanciadores;
    });
  }

  @override
  Widget build(BuildContext context) {
    final vPerfilPreInversionCubit =
        BlocProvider.of<VPerfilPreInversionCubit>(context);

    final perfilPreInversionCofinanciadorCubit =
        BlocProvider.of<PerfilPreInversionCofinanciadorCubit>(context);

    final perfilPreInversionCofinanciadorDesembolsosBloc =
        BlocProvider.of<PerfilPreInversionCofinanciadorDesembolsosBloc>(
            context);
    final perfilPreInversionCofinanciadorActividadesFinancierasBloc =
        BlocProvider.of<
            PerfilPreInversionCofinanciadorActividadesFinancierasBloc>(context);
    final perfilPreInversionCofinanciadorRubrosBloc =
        BlocProvider.of<PerfilPreInversionCofinanciadorRubrosBloc>(context);
    final perfilPreInversionId = vPerfilPreInversionCubit
        .state.vPerfilPreInversion!.perfilPreInversionId;

    final perfilPreInversionCofinanciadorId =
        perfilPreInversionCofinanciadorCubit
            .state.perfilPreInversionCofinanciador.cofinanciadorId;

    return MultiBlocListener(
        listeners: [
          BlocListener<PerfilPreInversionCofinanciadorDesembolsoCubit,
              PerfilPreInversionCofinanciadorDesembolsoState>(
            listener: (context, state) {
              if (state is PerfilPreInversionCofinanciadorDesembolsoLoaded) {
                perfilPreInversionCofinanciadorDesembolsosBloc.add(
                    GetPerfilPreInversionCofinanciadorDesembolsosByCofinanciador(
                        perfilPreInversionId: perfilPreInversionId,
                        cofinanciadorId: perfilPreInversionCofinanciadorId!));
              }
            },
          ),
          BlocListener<PerfilPreInversionCofinanciadorActividadFinancieraCubit,
              PerfilPreInversionCofinanciadorActividadFinancieraState>(
            listener: (context, state) {
              if (state
                  is PerfilPreInversionCofinanciadorActividadFinancieraLoaded) {
                perfilPreInversionCofinanciadorActividadesFinancierasBloc.add(
                    GetPerfilPreInversionCofinanciadorActividadesFinancierasByCofinanciador(
                        perfilPreInversionId: perfilPreInversionId,
                        cofinanciadorId: perfilPreInversionCofinanciadorId!));
              }
            },
          ),
          BlocListener<PerfilPreInversionCofinanciadorRubroCubit,
              PerfilPreInversionCofinanciadorRubroState>(
            listener: (context, state) {
              if (state is PerfilPreInversionCofinanciadorRubroLoaded) {
                perfilPreInversionCofinanciadorRubrosBloc.add(
                    GetPerfilPreInversionCofinanciadorRubrosByCofinanciador(
                        perfilPreInversionId: perfilPreInversionId,
                        cofinanciadorId: perfilPreInversionCofinanciadorId!));
              }
            },
          ),
        ],
        child: ListView(
          children: [
            TextField(
              onChanged: (value) => _buscar(value),
              decoration: const InputDecoration(
                labelText: 'Buscar',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            PaginatedDataTable(
              header: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Cofinanciadores'),
                  IconButton(
                      onPressed: () => Navigator.pushNamed(
                          context, 'NewEditVCofinanciadorPreInversion'),
                      icon: const Icon(Icons.add))
                ],
              ),
              rowsPerPage: 10, // Adjust as needed
              columns: const <DataColumn>[
                DataColumn(label: Text('Id')),
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Monto')),
              ],
              source: PerfilPreInversionCofinanciadoresTableSource(
                  context, perfilPreInversionCofinanciadoresFiltered),
            ),
          ],
        ));
  }
}
