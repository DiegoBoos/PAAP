import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/perfil_preinversion_aliado_entity.dart';
import '../../cubits/perfil_preinversion_aliado/perfil_preinversion_aliado_cubit.dart';
import '../../utils/no_data_svg.dart';

class PerfilPreInversionAliadosTableSource extends DataTableSource {
  final BuildContext context;
  final List<PerfilPreInversionAliadoEntity> perfilPreInversionAliados;

  PerfilPreInversionAliadosTableSource(
      this.context, this.perfilPreInversionAliados);

  @override
  DataRow getRow(int index) {
    final perfilPreInversionAliado = perfilPreInversionAliados[index];

    final perfilPreInversionAliadoCubit =
        BlocProvider.of<PerfilPreInversionAliadoCubit>(context);

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(perfilPreInversionAliado.aliadoId!)),
        DataCell(TextButton(
          onPressed: () {
            perfilPreInversionAliadoCubit
                .setPerfilPreInversionAliado(perfilPreInversionAliado);

            Navigator.pushNamed(
              context,
              'NewEditAliadoPreInversion',
            );
          },
          child: SizedBox(
            width: 200,
            child: Text(
              perfilPreInversionAliado.nombre!,
            ),
          ),
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => perfilPreInversionAliados.length;

  @override
  int get selectedRowCount => 0;
}

class PerfilPreInversionAliadosRows extends StatefulWidget {
  const PerfilPreInversionAliadosRows({
    Key? key,
    required this.perfilPreInversionAliados,
  }) : super(key: key);

  final List<PerfilPreInversionAliadoEntity> perfilPreInversionAliados;

  @override
  State<PerfilPreInversionAliadosRows> createState() =>
      _PerfilPreInversionAliadosRowsState();
}

class _PerfilPreInversionAliadosRowsState
    extends State<PerfilPreInversionAliadosRows> {
  List<PerfilPreInversionAliadoEntity> perfilPreInversionAliadosFiltered = [];

  void _buscar(String query) {
    final lowerCaseQuery = query.toLowerCase();
    final perfilPreInversionAliados =
        widget.perfilPreInversionAliados.where((perfilPreInversionAliado) {
      return perfilPreInversionAliado.nombre!
          .toLowerCase()
          .contains(lowerCaseQuery);
    }).toList();

    setState(() {
      perfilPreInversionAliadosFiltered = perfilPreInversionAliados;
    });
  }

  @override
  Widget build(BuildContext context) {
    perfilPreInversionAliadosFiltered = widget.perfilPreInversionAliados;
    return widget.perfilPreInversionAliados.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'PreInversión Aliados',
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, 'NewEditAliadoPreInversion');
                        },
                        icon: const Icon(
                          Icons.add,
                        ))
                  ],
                ),
              ),
              const Expanded(child: NoDataSvg(title: 'No hay resultados')),
            ],
          )
        : ListView(
            children: [
              TextField(
                onChanged: (value) => _buscar(value),
                decoration: const InputDecoration(
                  labelText: 'Buscar',
                  suffixIcon: Icon(Icons.search),
                ),
              ),
              PaginatedDataTable(
                dataRowHeight: 250,
                header: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('PreInversión Aliados'),
                    IconButton(
                        onPressed: () => Navigator.pushNamed(
                            context, 'NewEditAliadoPreInversion'),
                        icon: const Icon(Icons.add))
                  ],
                ),
                rowsPerPage: 10, // Adjust as needed
                columns: const <DataColumn>[
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Nombre')),
                ],
                source: PerfilPreInversionAliadosTableSource(
                    context, perfilPreInversionAliadosFiltered),
              ),
            ],
          );
  }
}
