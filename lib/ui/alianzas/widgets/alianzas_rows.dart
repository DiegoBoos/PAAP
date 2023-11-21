import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/cubits/v_alianza/v_alianza_cubit.dart';
import '../../../domain/entities/v_alianza_entity.dart';

class VAlianzasTableSource extends DataTableSource {
  final BuildContext context;
  final List<VAlianzaEntity> vAlianzas;

  VAlianzasTableSource(this.context, this.vAlianzas);

  @override
  DataRow getRow(int index) {
    final vAlianza = vAlianzas[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(vAlianza.alianzaId)),
        DataCell(TextButton(
          onPressed: () {
            BlocProvider.of<VAlianzaCubit>(context).selectVAlianza(vAlianza);
            Navigator.pushNamed(context, 'VAlianza');
          },
          child: Text(
            vAlianza.nombre,
          ),
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => vAlianzas.length;

  @override
  int get selectedRowCount => 0;
}

class AlianzasRows extends StatefulWidget {
  const AlianzasRows({
    Key? key,
    required this.alianzas,
  }) : super(key: key);

  final List<VAlianzaEntity> alianzas;

  @override
  State<AlianzasRows> createState() => _AlianzasRowsState();
}

class _AlianzasRowsState extends State<AlianzasRows> {
  List<VAlianzaEntity> vAlianzasFiltered = [];
  List<VAlianzaEntity> allVAlianzas = [];

  bool enableId = false;

  @override
  void initState() {
    super.initState();
    allVAlianzas = widget.alianzas;
    vAlianzasFiltered = allVAlianzas;
  }

  void _buscar(String query) {
    final lowerCaseQuery = query.toLowerCase();

    if (enableId) {
      final vAlianzas = allVAlianzas.where((vAlianza) {
        return vAlianza.alianzaId.toLowerCase().contains(lowerCaseQuery);
      }).toList();

      setState(() {
        vAlianzasFiltered = vAlianzas;
      });
      return;
    } else {
      final vAlianzas = allVAlianzas.where((vAlianza) {
        return vAlianza.nombre.toLowerCase().contains(lowerCaseQuery);
      }).toList();

      setState(() {
        vAlianzasFiltered = vAlianzas;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TextField(
          onChanged: (value) => _buscar(value),
          decoration: InputDecoration(
            labelText: enableId ? 'Buscar por id' : 'Buscar por nombre',
            suffixIcon: const Icon(Icons.search),
          ),
        ),
        PaginatedDataTable(
          header: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Alianzas'),
              IconButton(
                  onPressed: () {
                    setState(() {
                      enableId = !enableId;
                    });
                  },
                  icon: const Icon(Icons.filter_alt))
            ],
          ),
          rowsPerPage: 10, // Adjust as needed
          columns: const <DataColumn>[
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Nombre')),
          ],
          source: VAlianzasTableSource(context, vAlianzasFiltered),
        ),
      ],
    );
  }
}
