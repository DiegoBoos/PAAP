import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/perfil_cofinanciador_entity.dart';

class PerfilCofinanciadoresTableSource extends DataTableSource {
  final BuildContext context;
  final List<PerfilCofinanciadorEntity> perfilCofinanciadores;

  PerfilCofinanciadoresTableSource(this.context, this.perfilCofinanciadores);

  @override
  DataRow getRow(int index) {
    final perfilCofinanciador = perfilCofinanciadores[index];

    final monto =
        NumberFormat.currency(locale: 'en_US', decimalDigits: 0, symbol: "\$")
            .format(double.parse(perfilCofinanciador.monto));

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(perfilCofinanciador.cofinanciadorId!)),
        DataCell(TextButton(
            onPressed: perfilCofinanciador.correo == 'TOTAL'
                ? null
                : () async {
                    final navigator = Navigator.of(context);

                    navigator.pushNamed('NewEditVCofinanciador',
                        arguments: perfilCofinanciador);
                  },
            child: Text(perfilCofinanciador.nombre!))),
        DataCell(Text(monto)),
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

  @override
  void initState() {
    super.initState();
    perfilCofinanciadoresFiltered = widget.perfilCofinanciadores;
  }

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
              const Text('Cofinanciadores'),
              IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, 'NewEditVCofinanciador'),
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
