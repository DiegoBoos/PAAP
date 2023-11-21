import 'package:flutter/material.dart';

import '../../../domain/entities/aliado_entity.dart';

class AliadosTableSource extends DataTableSource {
  final BuildContext context;
  final List<AliadoEntity> aliados;

  AliadosTableSource(this.context, this.aliados);

  @override
  DataRow getRow(int index) {
    final aliado = aliados[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(aliado.aliadoId)),
        DataCell(TextButton(
            onPressed: () {
              Navigator.pushNamed(context, 'NewEditVAliado', arguments: aliado);
            },
            child: Text(aliado.nombre))),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => aliados.length;

  @override
  int get selectedRowCount => 0;
}

class AliadosRows extends StatefulWidget {
  const AliadosRows({
    Key? key,
    required this.aliados,
  }) : super(key: key);

  final List<AliadoEntity> aliados;

  @override
  State<AliadosRows> createState() => _AliadosRowsState();
}

class _AliadosRowsState extends State<AliadosRows> {
  List<AliadoEntity> aliadosFiltered = [];
  List<AliadoEntity> allAliados = [];

  @override
  void initState() {
    super.initState();
    allAliados = widget.aliados;
    aliadosFiltered = allAliados;
  }

  void _buscar(String query) {
    final lowerCaseQuery = query.toLowerCase();
    final aliados = allAliados.where((aliado) {
      return aliado.nombre.toLowerCase().contains(lowerCaseQuery);
    }).toList();

    setState(() {
      aliadosFiltered = aliados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
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
              const Text('Aliados'),
              IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, 'NewEditVAliado'),
                  icon: const Icon(Icons.add))
            ],
          ),
          rowsPerPage: 10, // Adjust as needed
          columns: const <DataColumn>[
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Nombre')),
          ],
          source: AliadosTableSource(context, aliadosFiltered),
        ),
      ],
    );
  }
}
