import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/perfil_cofinanciador_entity.dart';
import '../../cubits/perfil_cofinanciador/perfil_cofinanciador_cubit.dart';
import '../../utils/no_data_svg.dart';

class PerfilCofinanciadoresTableSource extends DataTableSource {
  final BuildContext context;
  final List<PerfilCofinanciadorEntity> perfilCofinanciadores;

  PerfilCofinanciadoresTableSource(this.context, this.perfilCofinanciadores);

  @override
  DataRow getRow(int index) {
    final perfilCofinanciador = perfilCofinanciadores[index];

    final perfilCofinanciadorCubit =
        BlocProvider.of<PerfilCofinanciadorCubit>(context);

    String? monto;
    if (perfilCofinanciador.monto != null || perfilCofinanciador.monto != '') {
      monto =
          NumberFormat.currency(locale: 'en_US', decimalDigits: 0, symbol: "\$")
              .format(double.parse(perfilCofinanciador.monto!));
    }

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(perfilCofinanciador.cofinanciadorId!)),
        DataCell(TextButton(
            onPressed: perfilCofinanciador.correo == 'TOTAL'
                ? null
                : () async {
                    final navigator = Navigator.of(context);

                    perfilCofinanciadorCubit
                        .setPerfilCofinanciador(perfilCofinanciador);

                    navigator.pushNamed(
                      'NewEditVPerfilCofinanciador',
                    );
                  },
            child: Text(perfilCofinanciador.nombre!))),
        DataCell(SizedBox(
          width: 200,
          child: Text(
            monto ?? '',
          ),
        ))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => perfilCofinanciadores.length;

  @override
  int get selectedRowCount => 0;
}

class PerfilCofinanciadorRows extends StatefulWidget {
  const PerfilCofinanciadorRows({
    Key? key,
    required this.perfilCofinanciadores,
  }) : super(key: key);

  final List<PerfilCofinanciadorEntity> perfilCofinanciadores;

  @override
  State<PerfilCofinanciadorRows> createState() =>
      _PerfilCofinanciadorRowsState();
}

class _PerfilCofinanciadorRowsState extends State<PerfilCofinanciadorRows> {
  List<PerfilCofinanciadorEntity> perfilCofinanciadoresFiltered = [];

  void _buscar(String query) {
    final lowerCaseQuery = query.toLowerCase();
    final perfilCofinanciadores =
        widget.perfilCofinanciadores.where((perfilCofinanciador) {
      return perfilCofinanciador.nombre!.toLowerCase().contains(lowerCaseQuery);
    }).toList();

    setState(() {
      perfilCofinanciadoresFiltered = perfilCofinanciadores;
    });
  }

  @override
  Widget build(BuildContext context) {
    perfilCofinanciadoresFiltered = widget.perfilCofinanciadores;
    return widget.perfilCofinanciadores.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Perfil Cofinanciadores',
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, 'NewEditVPerfilCofinanciador');
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
                    const Text('Cofinanciadores'),
                    IconButton(
                        onPressed: () => Navigator.pushNamed(
                            context, 'NewEditVPerfilCofinanciador'),
                        icon: const Icon(Icons.add))
                  ],
                ),
                rowsPerPage: 10, // Adjust as needed
                columns: const <DataColumn>[
                  DataColumn(label: Text('Id')),
                  DataColumn(label: Text('Nombre')),
                  DataColumn(label: Text('Monto')),
                ],
                source: PerfilCofinanciadoresTableSource(
                    context, perfilCofinanciadoresFiltered),
              ),
            ],
          );
  }
}
