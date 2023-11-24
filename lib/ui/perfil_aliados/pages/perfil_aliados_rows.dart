import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/perfil_aliado_entity.dart';
import '../../cubits/perfil_aliado/perfil_aliado_cubit.dart';

class PerfilAliadosTableSource extends DataTableSource {
  final BuildContext context;
  final List<PerfilAliadoEntity> perfilAliados;

  PerfilAliadosTableSource(this.context, this.perfilAliados);

  @override
  DataRow getRow(int index) {
    final perfilAliado = perfilAliados[index];

    final perfilAliadoCubit = BlocProvider.of<PerfilAliadoCubit>(context);

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(perfilAliado.aliadoId!)),
        DataCell(TextButton(
            onPressed: () {
              perfilAliadoCubit.setPerfilAliado(perfilAliado);

              Navigator.pushNamed(
                context,
                'NewEditVPerfilAliado',
              );
            },
            child: Text(perfilAliado.aliado ?? ''))),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => perfilAliados.length;

  @override
  int get selectedRowCount => 0;
}

class PerfilAliadosRows extends StatefulWidget {
  const PerfilAliadosRows({
    Key? key,
    required this.perfilAliados,
  }) : super(key: key);

  final List<PerfilAliadoEntity> perfilAliados;

  @override
  State<PerfilAliadosRows> createState() => _PerfilAliadosRowsState();
}

class _PerfilAliadosRowsState extends State<PerfilAliadosRows> {
  List<PerfilAliadoEntity> perfilAliadosFiltered = [];
  List<PerfilAliadoEntity> allPerfilAliados = [];

  @override
  void initState() {
    super.initState();
    allPerfilAliados = widget.perfilAliados;
    perfilAliadosFiltered = allPerfilAliados;
  }

  void _buscar(String query) {
    final lowerCaseQuery = query.toLowerCase();
    final perfilAliados = allPerfilAliados.where((perfilAliado) {
      return perfilAliado.aliado!.toLowerCase().contains(lowerCaseQuery);
    }).toList();

    setState(() {
      perfilAliadosFiltered = perfilAliados;
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
              const Text('PerfilAliados'),
              IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, 'NewEditVPerfilAliado'),
                  icon: const Icon(Icons.add))
            ],
          ),
          rowsPerPage: 10, // Adjust as needed
          columns: const <DataColumn>[
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Nombre')),
          ],
          source: PerfilAliadosTableSource(context, perfilAliadosFiltered),
        ),
      ],
    );
  }
}
